## Bowling Score Calculator

The calculator's input is a string that consists of:
  - [1-9] numbers
  - "x" for [strike](http://lmgtfy.com/?q=what+is+strike+in+bowling)
  - "/" for [spare](http://lmgtfy.com/?q=what+is+spare+in+bowling)
  - "-" for miss

For example, a Thanksgiving Turkey (300) looks like this:

> xxxxxxxxxx

whereas a regular game (82) would be

> 9/3561368153258-7181

### Todo

Calculate the final score for a ten-pin bowling game by implementing the **ScoreKeeper** class. Please send your solution once tests are green.

### Bonus points

- solution written in ruby
- additional tests for egde cases


### Running tests

Make sure to have *ruby* and *rspec* installed,
* rspec ~> 3.0
* ruby ~> 2.0

then run command
```sh
$ cd bowling/
$ rspec bowling_spec.rb
```
