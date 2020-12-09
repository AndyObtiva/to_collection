# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: to_collection 2.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "to_collection".freeze
  s.version = "2.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andy Maleh".freeze]
  s.date = "2020-12-09"
  s.description = "ToCollection Ruby Refinement - Treat an array of objects and a singular object uniformly as a collection of objects".freeze
  s.email = "andy.am@gmail.com".freeze
  s.extra_rdoc_files = [
    "CHANGELOG.md",
    "LICENSE",
    "README.md"
  ]
  s.files = [
    "CHANGELOG.md",
    "README.md",
    "VERSION",
    "lib/to_collection.rb",
    "to_collection.gemspec"
  ]
  s.homepage = "http://github.com/AndyObtiva/to_collection".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "ToCollection Ruby Refinement - Treat an array of objects and a singular object uniformly as a collection of objects".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<jeweler>.freeze, ["~> 2.3.3"])
    s.add_development_dependency(%q<coveralls>.freeze, ["~> 0.8.19"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
  else
    s.add_dependency(%q<jeweler>.freeze, ["~> 2.3.3"])
    s.add_dependency(%q<coveralls>.freeze, ["~> 0.8.19"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
  end
end

