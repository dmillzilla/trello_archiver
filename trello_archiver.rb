require 'trello'
require 'yaml'
require 'date'

config = YAML::load_file(File.join(File.dirname(File.realpath(__FILE__)), ".config"))
@trello_config = config["trello_config"]
trello_board_arr = []

Trello.configure do |c|
  c.developer_public_key = @trello_config["APP_KEY"]
  c.member_token = @trello_config["TOKEN"]
end

trello_boards = Trello::Board.all
trello_boards.each do |board|
  trello_board_arr << {:id => board.id, :name => board.name}
end

def board_archive_prompt(trello_board_hash)
  puts "Would you like to archive old cards from \"#{trello_board_hash[:name]}\"? (y/n)"
  print "> "
  @board_archive_choice = $stdin.gets.chomp
  unless ['y','yes','n','no'].include?(@board_archive_choice)
    puts 'That is not a valid input.'
    board_archive_prompt(trello_board_hash)
  end
end

trello_board_arr.each do |trello_board_hash|
  board_archive_prompt(trello_board_hash)
  next unless ['y','yes'].include?(@board_archive_choice)
    trello_board = Trello::Board.find(trello_board_hash[:id])
    trello_board.cards.each do |card|
      if card.due && card.due < (Date.today - 90).to_s
        Trello::Card.find(card.id).close!
        puts "closing #{card.name}"
      end
    end
end
