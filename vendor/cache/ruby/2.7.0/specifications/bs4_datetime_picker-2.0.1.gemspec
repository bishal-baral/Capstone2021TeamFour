# -*- encoding: utf-8 -*-
# stub: bs4_datetime_picker 2.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "bs4_datetime_picker".freeze
  s.version = "2.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Robert David".freeze]
  s.date = "2019-09-13"
  s.description = "Simple gem for datetime pickers for bootstrap 4".freeze
  s.email = ["rdavid369@gmail.com".freeze]
  s.homepage = "https://github.com/rdavid369/bs4-datetime-picker".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Simple gem for datetime pickers for bootstrap 4".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<moment-timezone-rails>.freeze, ["~> 1.0"])
    s.add_runtime_dependency(%q<momentjs-rails>.freeze, [">= 2.10.5", "<= 3.0.0"])
    s.add_runtime_dependency(%q<rails>.freeze, [">= 4.2.11"])
    s.add_development_dependency(%q<bootstrap>.freeze, ["~> 4.3.1"])
    s.add_development_dependency(%q<font-awesome-rails>.freeze, [">= 0"])
    s.add_development_dependency(%q<jquery-rails>.freeze, [">= 0"])
    s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
  else
    s.add_dependency(%q<moment-timezone-rails>.freeze, ["~> 1.0"])
    s.add_dependency(%q<momentjs-rails>.freeze, [">= 2.10.5", "<= 3.0.0"])
    s.add_dependency(%q<rails>.freeze, [">= 4.2.11"])
    s.add_dependency(%q<bootstrap>.freeze, ["~> 4.3.1"])
    s.add_dependency(%q<font-awesome-rails>.freeze, [">= 0"])
    s.add_dependency(%q<jquery-rails>.freeze, [">= 0"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
  end
end
