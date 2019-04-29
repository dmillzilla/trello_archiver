# Trello Card Archiver

A simple script designed to archive cards that have been marked as completed more than 90 days. Keep each of your Trello boards nice and clean!

## Dependencies Needed

- Ruby v2.3.4

## Setup

1. Perform the setup script from the `trello_archiver` directory:

  ```bash
./bin/setup
```

2. Enter your Trello App Key, found at https://www.trello.com/app_key

3. Enter your Trello Token, found by clicking **Token** from App Key page in Step 2

## Usage

1. Start the Trello Card Archiver:

  ```bash
ruby trello_archiver.rb
```

2. Answer either `y` or `n` for whether you'd like cards archived from the boards as they are mentioned.
