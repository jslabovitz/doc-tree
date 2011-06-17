# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'hashstruct'

Gem::Specification.new do |s|
  s.name          = 'hashstruct'
  s.version       = HashStruct::VERSION
  s.summary       = 'Overly helpful magic hash structure.'
  
  s.author        = 'John Labovitz'
  s.email         = 'johnl@johnlabovitz.com'
  s.description   = %q{
    HashStruct provides an object based on Hash, but acts like Struct (or OpenStruct), providing helpful
    accessors for each key from the get-go. It also magically parses string values when it can (eg, dates,
    URIs, numbers, and does so recursively.
  }
  s.homepage      = 'http://github.com/jslabovitz/hashstruct'
  
  s.files         = Dir.glob('lib/**/*') + %w(README.mdown)
  s.require_path  = 'lib'
  s.required_rubygems_version = '>= 1.6.2'
end