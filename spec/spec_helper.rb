ENV['APP_ENV'] = 'test'
require 'rubygems'
require 'bundler'
begin
  Bundler.require(:default, :development, :test)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
if RUBY_VERSION >= '2.3' && !defined?(Rubinius)
  begin
    require 'coveralls'
    Coveralls.wear!
  rescue LoadError, StandardError => e
    #no op to support Rubies that do not support Coveralls
    puts 'Error loading Coveralls'
    puts e.message
    puts e.backtrace.join("\n")
  end
end
require_relative '../lib/to_collection'
