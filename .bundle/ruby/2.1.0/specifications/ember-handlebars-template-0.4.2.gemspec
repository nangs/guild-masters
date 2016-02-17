# -*- encoding: utf-8 -*-
# stub: ember-handlebars-template 0.4.2 ruby lib

Gem::Specification.new do |s|
  s.name = "ember-handlebars-template"
  s.version = "0.4.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Ryunosuke SATO"]
  s.bindir = "exe"
  s.date = "2015-10-06"
  s.description = "The sprockets template for Ember Handlebars."
  s.email = ["tricknotes.rs@gmail.com"]
  s.homepage = "https://github.com/tricknotes/ember-handlebars-template"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "The sprockets template for Ember Handlebars."

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sprockets>, ["< 3.5", ">= 3.3"])
      s.add_runtime_dependency(%q<barber>, [">= 0.9.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.7"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
    else
      s.add_dependency(%q<sprockets>, ["< 3.5", ">= 3.3"])
      s.add_dependency(%q<barber>, [">= 0.9.0"])
      s.add_dependency(%q<bundler>, ["~> 1.7"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
      s.add_dependency(%q<minitest>, [">= 0"])
    end
  else
    s.add_dependency(%q<sprockets>, ["< 3.5", ">= 3.3"])
    s.add_dependency(%q<barber>, [">= 0.9.0"])
    s.add_dependency(%q<bundler>, ["~> 1.7"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
    s.add_dependency(%q<minitest>, [">= 0"])
  end
end
