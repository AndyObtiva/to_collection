# ToCollection 2.0.0 Ruby Refinement
[![Gem Version](https://badge.fury.io/rb/to_collection.svg)](http://badge.fury.io/rb/to_collection)
[![Build Status](https://travis-ci.org/AndyObtiva/to_collection.svg?branch=master)](https://travis-ci.org/AndyObtiva/to_collection)
[![Coverage Status](https://coveralls.io/repos/github/AndyObtiva/to_collection/badge.svg?branch=master)](https://coveralls.io/github/AndyObtiva/to_collection?branch=master)

Treat an array of objects and a singular object uniformly as a collection of objects.

Especially useful in processing REST Web Service API JSON responses in a uniform functional approach.

`ToCollection` is a Ruby Refinement, so it may be safely enabled via `using ToCollection` where needed only.

## Introduction

Canonicalize data to treat uniformly whether it comes in as a single object or an array of objects, dropping `nils` out automatically.

API: `object#to_collection(compact=true)` where `compact` is a boolean for whether to compact collection or not. It is true by default.

Example:

```ruby
city_counts = {}
people_http_request.to_collection.each do |person|
  city_counts[person["city"]] ||= 0
  city_counts[person["city"]] += 1
end
```

Wanna keep `nil` values? No problem! Just pass `false` as an argument:

```ruby
bad_people_count = 0
city_counts = {}
people_http_request.to_collection(false).each do |person|
  if person.nil?
    bad_people_count += 1
  else
    city_counts[person["city"]] ||= 0
    city_counts[person["city"]] += 1
  end
end
```

## Instructions

### Bundler

- Add `gem 'to_collection', '~> 2.0.0'` to Gemfile
- Run `bundle`
- Require `to_collection` ruby gem in code (e.g. via `Bundler.require(:default)` or `require 'bundler/setup'` & `require 'to_collection'`)
- Add `using ToCollection` to the top of the Ruby file you would like to refine `Object` in with `#to_collection` method.

### Manual Gem Install

- Run `gem install to_collection -v2.0.0`
- Add `require 'to_collection'` to code
- Add `using ToCollection` to the top of the Ruby file you would like to refine `Object` in with `#to_collection` method.

### Note

If '#to_collection' was already defined on `Object` in a project, requiring the `to_collection` library will print a warning. 

It is still safe to require as it does not overwrite `Object#to_collection` except in Ruby files where `using ToCollection` is added.

## Background

I'm sure you've encountered REST Web Service APIs that operate as follows:

HTTP Request: =>
```
GET /people
```

<= 1 person
JSON Response:
```JSON
{"first_name":"John","last_name":"Barber","city":"Chicago"}
```

HTTP Request: =>
```
GET /people
```

<= 3 people
JSON Response:

```JSON
[{"first_name":"John","last_name":"Barber","city":"Chicago"}, {"first_name":"Mark","last_name":"Jones","city":"New York"}, {"first_name":"Josh","last_name":"Beeswax","city":"Denver"}]
```

How do you work with the varied JSON responses in Ruby?

One approach for an app that needs to count people in cities:

```ruby
city_counts = {}
json_response = people_http_request
if json_response.is_a?(Hash)
  city_counts[json_response["city"]] ||= 0
  city_counts[json_response["city"] += 1
elsif json_response.is_a?(Array)
  json_response.each do |person|
    city_counts[person["city"]] ||= 0
    city_counts[person["city"]] += 1
  end
end
```

Not only is the code above repetitive (unDRY) and complicated, but it also breaks common Ruby and object oriented development standards by relying on explicit type checking instead of duck-typing, polymorphism, or design patterns.

A slightly better version relying on duck-typing would be:

```ruby
city_counts = {}
json_response = people_http_request
if json_response.respond_to?(:each_pair)
  city_counts[json_response["city"]] ||= 0
  city_counts[json_response["city"] += 1
elsif json_response.respond_to?(:each_index)
  json_response.each do |person|
    city_counts[person["city"]] ||= 0
    city_counts[person["city"]] += 1
  end
end
```

A slightly clearer version relying on design patterns (Strategy) and parametric polymorphism (functional) would be:

```ruby
city_counts = {}
city_counting_strategies = {
  Hash: -> { |json_response|
    city_counts[json_response["city"]] ||= 0
    city_counts[json_response["city"] += 1
  },
  Array: -> { |json_response|
    json_response.each do |person|
      city_counts[person["city"]] ||= 0
      city_counts[person["city"]] += 1
    end
  }
}
json_response = people_http_request
city_counting_strategies[json_response.class].call(json_response)
```

A more radical version relying on object-oriented polymorphism and Ruby open-classes would be:

```ruby
Hash.class_eval do
  def process_json_response(&processor)
    processor.call(self)
  end
end

Array.class_eval do
  def process_json_response(&processor)
    each(&processor)
  end
end

city_counts = {}
json_response = people_http_request
json_response.process_json_response do |person|
  city_counts[person["city"]] ||= 0
  city_counts[person["city"]] += 1
end
```

This version is quite elegant, clear, and Ruby idiomatic, but aren't we using a Nuclear device against a fly that sometimes comes as a swarm of flies? I'm sure we can have a much simpler solution, especially in a language like Ruby.

Well, how about this functional solution?

```ruby
city_counts = {}
[people_http_request].flatten.each do |person|
  city_counts[person["city"]] ||= 0
  city_counts[person["city"]] += 1
end
```

Yes, hybrid functional/object-oriented programming to the rescue.

One may wonder what to do if the response comes in as nil or includes nil values in an array. Well, this approach can scale to handle that too should ignoring nil be the requirement.

```ruby
city_counts = {}
[people_http_request].flatten.compact.each do |person|
  city_counts[person["city"]] ||= 0
  city_counts[person["city"]] += 1
end
```

Can we generalize this elegant solution beyond counting cities? After all, the key problem with the code on top is it gets quite expensive to maintain in a real-world production app containing many integrations with REST Web Service APIs.

This functional generalization should work by allowing you to switch json_response variable and process_json_response proc anyway you want:

```ruby
[json_response].flatten.compact.each(&:process_json_response)
```

Example:

```ruby
[cities_json_response].flatten.compact.each(&:group_by_country)
```

How about go one step further and bake this into all objects using our previous approach of object-oriented polymorphism and Ruby open-classes? That way, we don't just collapse the difference between dealing with arrays of hashes vs hashes but also arrays of objects vs singular objects by adding. Note the use of flatten(1) below to prevent arrays or arrays from collapsing more than one level.

```ruby
class Object
  def to_collection
    [self].flatten(1).compact
  end
end
```

Example usage (notice how more readable this is than the explicit version above by hiding flatten and compact):

```ruby
city_counts = {}
people_http_request.to_collection.each do |person|
  city_counts[person["city"]] ||= 0
  city_counts[person["city"]] += 1
end
```

A refactored version including optional compacting would be:

```ruby
class Object
  def to_collection(compact=true)
    collection = [self].flatten(1)
    compact ? collection.compact : collection
  end
end
```

Example usage of `to_collection(compact)` to count bad person hashes coming as nil:

```ruby
bad_people_count = 0
city_counts = {}
people_http_request.to_collection(false).each do |person|
  if person.nil?
    bad_people_count += 1
  else
    city_counts[person["city"]] ||= 0
    city_counts[person["city"]] += 1
  end
end
```

Of course, in Ruby 2+, you may use Ruby Refinements, so simply include `Object#to_collection` via this line instead:

```ruby
using ToCollection
```

You asked for "Elegant" didn't you? I hope that was what you were looking for.

## How It Works

A Ruby Refinement is activated via `using ToCollection` adding/overwriting the `#to_collection` method in `Object`, which 
is the ancestor of all Ruby objects.

## Release Notes

### v2.0.0

- Revamped API using Ruby Refinements (safer than monkey-patching)
- Removed `super_module` gem dependency
- Dropped safety options since Ruby Refinements already handle things safely

### v1.0.1

- Updated `super_module` gem version to relax indirect `method_source` gem version dependency

## Contributing

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* `gem install bundler`
* `bundle`
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally. Also, do not upgrade `jeweler`. It is intentionally at an old version that is compatible with running tests in Travis with older verison of Ruby as well as supporting Coveralls, Simplecov, and Code Climate.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2017-2020 Andy Maleh. See LICENSE.txt for
further details.
