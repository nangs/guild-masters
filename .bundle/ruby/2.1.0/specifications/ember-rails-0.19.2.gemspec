# -*- encoding: utf-8 -*-
# stub: ember-rails 0.19.2 ruby lib

Gem::Specification.new do |s|
  s.name = "ember-rails"
  s.version = "0.19.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Keith Pitt", "Rob Monie", "Joao Carlos", "Paul Chavard"]
  s.date = "2015-08-28"
  s.email = ["me@keithpitt.com", "paul@chavard.net"]
  s.homepage = "https://github.com/emberjs/ember-rails"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "Ember for Rails 3.1+"

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, [">= 3.1"])
      s.add_runtime_dependency(%q<active_model_serializers>, [">= 0"])
      s.add_runtime_dependency(%q<jquery-rails>, [">= 1.0.17"])
      s.add_runtime_dependency(%q<ember-source>, [">= 1.8.0"])
      s.add_runtime_dependency(%q<ember-data-source>, [">= 1.13.0"])
      s.add_runtime_dependency(%q<active-model-adapter-source>, [">= 1.13.0"])
      s.add_runtime_dependency(%q<ember-handlebars-template>, ["< 1.0", ">= 0.1.1"])
      s.add_development_dependency(%q<bundler>, [">= 1.2.2"])
      s.add_development_dependency(%q<appraisal>, [">= 1.0.0"])
      s.add_development_dependency(%q<tzinfo>, [">= 0"])
      s.add_development_dependency(%q<vcr>, [">= 0"])
      s.add_development_dependency(%q<webmock>, ["< 1.14.0"])
      s.add_development_dependency(%q<sprockets-rails>, [">= 0"])
      s.add_development_dependency(%q<handlebars-source>, ["< 3", "> 1.0.0"])
      s.add_development_dependency(%q<test-unit>, [">= 0"])
      s.add_development_dependency(%q<safe_yaml>, [">= 1.0.4"])
    else
      s.add_dependency(%q<railties>, [">= 3.1"])
      s.add_dependency(%q<active_model_serializers>, [">= 0"])
      s.add_dependency(%q<jquery-rails>, [">= 1.0.17"])
      s.add_dependency(%q<ember-source>, [">= 1.8.0"])
      s.add_dependency(%q<ember-data-source>, [">= 1.13.0"])
      s.add_dependency(%q<active-model-adapter-source>, [">= 1.13.0"])
      s.add_dependency(%q<ember-handlebars-template>, ["< 1.0", ">= 0.1.1"])
      s.add_dependency(%q<bundler>, [">= 1.2.2"])
      s.add_dependency(%q<appraisal>, [">= 1.0.0"])
      s.add_dependency(%q<tzinfo>, [">= 0"])
      s.add_dependency(%q<vcr>, [">= 0"])
      s.add_dependency(%q<webmock>, ["< 1.14.0"])
      s.add_dependency(%q<sprockets-rails>, [">= 0"])
      s.add_dependency(%q<handlebars-source>, ["< 3", "> 1.0.0"])
      s.add_dependency(%q<test-unit>, [">= 0"])
      s.add_dependency(%q<safe_yaml>, [">= 1.0.4"])
    end
  else
    s.add_dependency(%q<railties>, [">= 3.1"])
    s.add_dependency(%q<active_model_serializers>, [">= 0"])
    s.add_dependency(%q<jquery-rails>, [">= 1.0.17"])
    s.add_dependency(%q<ember-source>, [">= 1.8.0"])
    s.add_dependency(%q<ember-data-source>, [">= 1.13.0"])
    s.add_dependency(%q<active-model-adapter-source>, [">= 1.13.0"])
    s.add_dependency(%q<ember-handlebars-template>, ["< 1.0", ">= 0.1.1"])
    s.add_dependency(%q<bundler>, [">= 1.2.2"])
    s.add_dependency(%q<appraisal>, [">= 1.0.0"])
    s.add_dependency(%q<tzinfo>, [">= 0"])
    s.add_dependency(%q<vcr>, [">= 0"])
    s.add_dependency(%q<webmock>, ["< 1.14.0"])
    s.add_dependency(%q<sprockets-rails>, [">= 0"])
    s.add_dependency(%q<handlebars-source>, ["< 3", "> 1.0.0"])
    s.add_dependency(%q<test-unit>, [">= 0"])
    s.add_dependency(%q<safe_yaml>, [">= 1.0.4"])
  end
end
