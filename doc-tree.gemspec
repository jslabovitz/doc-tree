# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'doc-tree'

Gem::Specification.new do |s|
  s.name          = 'doc-tree'
  s.version       = DocTree::VERSION
  s.summary       = 'Handles a tree of marked-up documents. Includes a handy Rack app.'

  s.author        = 'John Labovitz'
  s.email         = 'johnl@johnlabovitz.com'
  s.description   = %q{
    FIXME
  }
  s.homepage      = 'http://github.com/jslabovitz/doc-tree'

  s.add_dependency  'rubytree',   '~> 0.8.1'
  s.add_dependency  'RedCloth',   '~> 4.2.7'
  s.add_dependency  'hashstruct', '~> 0.0.1'
  
  s.add_development_dependency 'wrong'
  
  s.required_rubygems_version = '>= 1.6.2'

  s.files        = Dir.glob('{bin,lib,test}/**/*') + %w()
  s.require_path = 'lib'
end