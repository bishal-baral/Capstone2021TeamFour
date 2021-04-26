# -*- encoding: utf-8 -*-
# stub: datetime_picker_input 4.17.47 ruby lib

Gem::Specification.new do |s|
  s.name = "datetime_picker_input".freeze
  s.version = "4.17.47"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Juanito".freeze, "Fatas".freeze]
  s.date = "2017-04-23"
  s.description = "Datetime picker wrapper of https://github.com/TrevorS/bootstrap3-datetimepicker-rails, for use with simple_form on Rails 4+.".freeze
  s.email = ["katehuang0320@gmail.com".freeze]
  s.homepage = "https://github.com/jollygoodcode/datetime_picker_input".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Datetime picker wrapper of https://github.com/TrevorS/bootstrap3-datetimepicker-rails, for use with simple_form on Rails 4+.".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<bootstrap3-datetimepicker-rails>.freeze, ["~> 4.17.47"])
    s.add_runtime_dependency(%q<momentjs-rails>.freeze, ["~> 2.17.1"])
  else
    s.add_dependency(%q<bootstrap3-datetimepicker-rails>.freeze, ["~> 4.17.47"])
    s.add_dependency(%q<momentjs-rails>.freeze, ["~> 2.17.1"])
  end
end
