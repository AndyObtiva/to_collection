# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: to_collection 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "to_collection".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Andy Maleh".freeze]
  s.date = "2017-02-22"
  s.description = "\n    Treat an array of objects and a singular object uniformly as a collection of objects. Especially useful in processing REST Web Service API JSON responses in a functional approach.\n\n    Canonicalize data to treat uniformly whether it comes in as a single object or an array of objects, dropping `nils` out automatically.\n\n    API: `object.to_collection(compact)` where `compact` is a boolean for whether to compact collection or not. It is true by default.\n\n    Example:\n\n    ```ruby\n    city_counts = {}\n    people_http_request.to_collection.each do |person|\n      city_counts[person[\"city\"]] ||= 0\n      city_counts[person[\"city\"]] += 1\n    end\n    ```\n\n    Wanna keep `nil` values? No problem! Just pass `false` as an argument:\n\n    ```ruby\n    bad_people_count = 0\n    city_counts = {}\n    people_http_request.to_collection(false).each do |person|\n      if person.nil?\n        bad_people_count += 1\n      else\n        city_counts[person[\"city\"]] ||= 0\n        city_counts[person[\"city\"]] += 1\n      end\n    end\n    ```\n  ".freeze
  s.email = "andy.am@gmail.com".freeze
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    "lib/ext/object.rb",
    "lib/to_collection.rb"
  ]
  s.homepage = "http://github.com/AndyObtiva/to_collection".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.10".freeze
  s.summary = "Treat an array of objects and a singular object uniformly as a collection of objects".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<super_module>.freeze, ["= 1.2.0"])
      s.add_development_dependency(%q<jeweler>.freeze, ["~> 2.3.3"])
      s.add_development_dependency(%q<coveralls>.freeze, ["~> 0.8.19"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    else
      s.add_dependency(%q<super_module>.freeze, ["= 1.2.0"])
      s.add_dependency(%q<jeweler>.freeze, ["~> 2.3.3"])
      s.add_dependency(%q<coveralls>.freeze, ["~> 0.8.19"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    end
  else
    s.add_dependency(%q<super_module>.freeze, ["= 1.2.0"])
    s.add_dependency(%q<jeweler>.freeze, ["~> 2.3.3"])
    s.add_dependency(%q<coveralls>.freeze, ["~> 0.8.19"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
  end
end

