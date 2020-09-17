# TextAnalyzer

A text analyzing program to satisfy the NewRelic code challenge.

## Setup

Bundler is required. If it is not installed, `gem install bundler`.

`bin/setup`

## Usage

`bin/text_analyzer file1.txt file2.txt`

`cat file.txt | bin/text_analyzer`

`bin/text_analyzer <(curl -s http://www.gutenberg.org/cache/epub/2009/pg2009.txt)`

## Running tests

`bundle exec rake`

## Design Decisions

* Use threads for IO when given multiple files. In Ruby, threading [won't
  speed up the actual analysis](https://en.wikipedia.org/wiki/Global_interpreter_lock),
  but it can help with IO-bound tasks like reading in files.
  * For simplicity, we assume that we are not given an excessively large number
    of input files, and start a new thread for each input file.
* In the event of a tie that spans the threshold of `TextAnalyzer::Analyzer::RANK_CUTOFF`,
  the behavior of the program is unspecified; as such, no attempt is made to apply ordering
  beyond the occurrence count.
