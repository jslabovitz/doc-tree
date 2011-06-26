# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name          = 'doc-tree'
  s.version       = '0.0.3'
  s.summary       = 'Handles a tree of marked-up documents. Includes a handy Rack app.'

  s.author        = 'John Labovitz'
  s.email         = 'johnl@johnlabovitz.com'
  s.description   = %q{
    DocTree handles a tree of document files that have been marked up in Textile. It includes a handy Rack app.
    It's intended to act as a very simple, small-scale content management system, when you don't need databases
    or dynamic updates.
  }
  s.homepage      = 'http://github.com/jslabovitz/doc-tree'

  s.add_dependency  'rubytree'
  s.add_dependency  'RedCloth'
  s.add_dependency  'hashstruct'
  
  s.add_development_dependency 'wrong'
  
  s.files        = Dir.glob('{bin,lib,test}/**/*') + %w(README.markdown)
  s.require_path = 'lib'
end