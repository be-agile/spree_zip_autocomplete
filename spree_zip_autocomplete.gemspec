# encoding: UTF-8
lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'spree_zip_autocomplete/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_zip_autocomplete'
  s.version     = SpreeZipAutocomplete::VERSION
  s.summary     = "spree_zip_autocomplete is a Spree extension that provides an API for address lookup by zipcode and auto-fills Spree::Address forms based on the input zipcode, supporting Japanese addresses."
  s.required_ruby_version = '>= 3.1.4'

  s.author      = 'be agile Co., Ltd.'
  s.email       = 'develop@be-agile.jp'
  s.homepage    = 'https://github.com/be-agile/spree_zip_autocomplete'
  s.licenses    = ['AGPL-3.0-or-later']

  s.files       = `git ls-files`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree', '= 5.3.6'
  s.add_dependency 'spree_admin', '= 5.3.6'
  s.add_dependency 'spree_storefront', '= 5.3.6'
  s.add_dependency 'jipcode'
  s.add_dependency 'deface'
end
