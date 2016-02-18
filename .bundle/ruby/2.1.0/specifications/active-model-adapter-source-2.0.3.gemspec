# -*- encoding: utf-8 -*-
# stub: active-model-adapter-source 2.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "active-model-adapter-source"
  s.version = "2.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Igor Terzic", "Yehuda Katz", "Tom Dale"]
  s.date = "2015-10-30"
  s.description = "ember-data active-model-adapter code wrapper for use with Ruby libs."
  s.email = ["wycats@gmail.com"]
  s.homepage = "https://github.com/ember-data/active-model-adapter"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "active-model-adapter source code wrapper."

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ember-data-source>, ["< 3.0", ">= 1.13"])
    else
      s.add_dependency(%q<ember-data-source>, ["< 3.0", ">= 1.13"])
    end
  else
    s.add_dependency(%q<ember-data-source>, ["< 3.0", ">= 1.13"])
  end
end
