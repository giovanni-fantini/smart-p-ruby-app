# Smart Pension Tech Test

The specifications for this technical submission as it was received can be located in the folder `SP Test - Ruby`.

## Requirements

To run the script you must have

- [Ruby 2.6.3](https://www.ruby-lang.org/en/news/2019/04/17/ruby-2-6-3-released/)

## Installation and usage instructions

- Clone or unpack this repo
- `$ bundle install`
- `$ bundle exec rspec` to run tests

To run the program you can simply invoke

```bash
$ ./app.rb webserver.log 
```

## Current output

The current program output looks like this:

```
+--------------+-------------+
| Report on total page views |
+--------------+-------------+
| Page         | Total Views |
+--------------+-------------+
| /about/2     | 90          |
| /contact     | 89          |
| /index       | 82          |
| /about       | 81          |
| /help_page/1 | 80          |
| /home        | 78          |
+--------------+-------------+
+--------------+--------------+
| Report on unique page views |
+--------------+--------------+
| Page         | Unique Views |
+--------------+--------------+
| /index       | 23           |
| /home        | 23           |
| /contact     | 23           |
| /help_page/1 | 23           |
| /about/2     | 22           |
| /about       | 21           |
+--------------+--------------+
```

## Implementation details

The implementation was written following SOLID and DRY principles in an attempt to completely encapsulate business behaviour but maintaining configurability to avoid code duplication. 

All classes are single purpose and have been named to reveal their intent and expose the same API which is a single class method `.call`. They all have been namespaced under a common *LogHandler* domain for eventual ease of transferability to a more structured application.

A brief overview of the classes as follows:
- *Parser::Base* - This is the skeleton of the parsing class that implements the interface and ensures that the provided input exists.
- *Parser::Csv* - This is the parsing class responsible for CSVs, and it implements the actual parsing logic such as defining a column_separator or reading the file. The class can take a block specifying some aggregating logic for the parsed lines, so to not overload memory - in case no block is given, it defaults to the normal CSV parsing behaviour returning an array of arrays of all the lines.
- *ViewsCounter* - This is the class containing the aggregating logic chosen for this application. Instead of reading all view logs into memory, it aggregates the page view count based on page and IP, e.g. `{"page" => { "Ip1" => 2, "Ip2" => 1 } }`. In the current implementation it is passed as a block to the Parser class.
- *ViewsCalculator* - This is the class containing the logic to digest the output of the Parser and calculate the required metrics. In the current implementation, it accepts only two modes (and returns an error otherwise): `:total` and `:unique`. The former calculates the total views of each page and the latter calculates the unique views by disregarding multiple views from the same IP address. It returns an array of arrays with each describing a page and the number of views.
- *ViewsPresenter* - This is the class in charge of formatting and presenting the output to the user. In our implementation, it takes the output of the calculator, sorts it in descending order, renders it into a nicely formatted table and outputs the table to STDOUT.

## Potential improvements

* The naming of classes, methods and variables. Good naming improves code readability but it's hard to achieve when coding alone without peer review.
* The testing of the ViewsPresenter currently doesn't test for the formatting of the output - I made an attempt but the implementation of the table rendering gem messed with Rspec's output matcher. 
* Improving the parser's configurability like accepting more file types, as well as adding input checking to ensure the file is in the required form.
* Checking performance of the chosen object types and potentially standardising over one across all the classes so to limit the number of object transformations the program has to perform.

## Testing coverage

Coverage report generated for RSpec to `./coverage`. 100.0% coverage achieved.

The coverage report can be viewed by opening `./coverage/index.html` in any browser.
