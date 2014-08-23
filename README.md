# HTTP Requests in Ruby
## Prerequisites
* ruby
* rubygems
* bundler
```
gem install bundler
```
## Setup
```
bundle install
```
```
ruby requests.rb
```
## Description
This is an exploration of the different ways you could possibly approach HTTP requests (presumably if you have to make tons of requests) in Ruby.
```
# Request.synchronous(n)
```
This basically performs requests one after another, which is fine if you have two or three. If you have to do hundreds of requests, this would be a very inefficient way to do things.
```
# Request.threaded(n)
```
Here, requests are placed on separate instances of Ruby's built-in Thread class and then joined together once complete. While you might think this would offer some significant improvements, you'd be wrong. Ruby 'threads' aren't real threads... not by default, anyway.
```
# Request.parallel(n)
```
This is where you start to see some major changes. The *parallel* gem does exactly what you think it does: It allows for separate threads to run in parallel, instead of being juggled back and forth by the [Ruby Global Interpreter Lock](http://en.wikipedia.org/wiki/Global_Interpreter_Lock). It's pretty nifty, and in the tests I've run, it improves elapsed times almost threefold.
```
# Request.typhoeus(n)
```
This one is simply fantastic. While performance varies and is comparable to *parallel*'s, *typhoeus* really shines when it comes down to working with huge numbers of requests. Plus, its API is beautiful and easy to understand, and I love [Greek](http://en.wikipedia.org/wiki/Typhon) [mythology](http://en.wikipedia.org/wiki/Lernaean_Hydra).
