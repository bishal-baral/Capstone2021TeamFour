# -*- encoding: utf-8 -*-
# stub: opentok 4.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "opentok".freeze
  s.version = "4.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Stijn Mathysen".freeze, "Karmen Blake".freeze, "Song Zheng".freeze, "Patrick Quinn-Graham".freeze, "Ankur Oberoi".freeze]
  s.date = "2021-01-28"
  s.description = "OpenTok is an API from TokBox that enables websites to weave live group video communication into their online experience. With OpenTok you have the freedom and flexibility to create the most engaging web experience for your users. This gem lets you generate sessions and tokens for OpenTok applications. It also includes support for working with OpenTok 2.0 archives. See <http://tokbox.com/opentok/platform> for more details.".freeze
  s.email = ["stijn@skylight.be".freeze, "karmenblake@gmail.com".freeze, "song@tokbox.com".freeze, "pqg@tokbox.com".freeze, "ankur@tokbox.com".freeze]
  s.homepage = "https://opentok.github.io/opentok-ruby-sdk".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Ruby gem for the OpenTok API".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, [">= 1.5"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 12.0.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.9.0"])
    s.add_development_dependency(%q<webmock>.freeze, [">= 2.3.2"])
    s.add_development_dependency(%q<vcr>.freeze, [">= 2.8.0"])
    s.add_development_dependency(%q<yard>.freeze, [">= 0.9.11"])
    s.add_runtime_dependency(%q<addressable>.freeze, ["~> 2.3"])
    s.add_runtime_dependency(%q<httparty>.freeze, [">= 0.18.0"])
    s.add_runtime_dependency(%q<activesupport>.freeze, [">= 2.0"])
    s.add_runtime_dependency(%q<jwt>.freeze, [">= 1.5.6"])
  else
    s.add_dependency(%q<bundler>.freeze, [">= 1.5"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.0.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.9.0"])
    s.add_dependency(%q<webmock>.freeze, [">= 2.3.2"])
    s.add_dependency(%q<vcr>.freeze, [">= 2.8.0"])
    s.add_dependency(%q<yard>.freeze, [">= 0.9.11"])
    s.add_dependency(%q<addressable>.freeze, ["~> 2.3"])
    s.add_dependency(%q<httparty>.freeze, [">= 0.18.0"])
    s.add_dependency(%q<activesupport>.freeze, [">= 2.0"])
    s.add_dependency(%q<jwt>.freeze, [">= 1.5.6"])
  end
end
