ENV['APP_ENV'] = 'test'
ENV['CODECLIMATE_REPO_TOKEN'] = ''
require 'rubygems'
require 'bundler'
begin
  Bundler.require(:default, :development, :test)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
begin
  require "codeclimate-test-reporter"
  require "simplecov"
  require 'coveralls'
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    CodeClimate::TestReporter::Formatter,
    Coveralls::SimpleCov::Formatter
  ]
  SimpleCov.start
rescue LoadError, StandardError => e
  #no op to support Ruby 1.8.7, ree and Rubinius which do not support Coveralls
  puts 'Error loading Coveralls, SimpleCov, or CodeClimate'
  puts e.message
  puts e.backtrace.join("\n")
end
require_relative '../lib/to_collection'
