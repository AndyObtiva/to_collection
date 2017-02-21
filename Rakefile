# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "to_collection"
  gem.homepage = "http://github.com/AndyObtiva/to_collection"
  gem.license = "MIT"
  gem.summary = %Q{Treat an array of objects and a singular object uniformly as a collection of objects}
  gem.description = %Q{
    Treat an array of objects and a singular object uniformly as a collection of objects. Especially useful in processing REST Web Service API JSON responses in a functional approach.

    Canonicalize data to treat uniformly whether it comes in as a single object or an array of objects, dropping `nils` out automatically.

    API: `object.to_collection(compact)` where `compact` is a boolean for whether to compact collection or not. It is true by default.

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
  }
  gem.email = "andy.am@gmail.com"
  gem.authors = ["AndyObtiva"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

desc "Code coverage detail"
task :simplecov do
  ENV['COVERAGE'] = "true"
  Rake::Task['spec'].execute
end

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "to_collection #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
