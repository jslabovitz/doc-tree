# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'doc-tree'

Gem::Specification.new do |s|
  s.name          = 'doc-tree'
  s.version       = DocTree::VERSION
  s.summary       = 'Handles a tree of marked-up documents. Includes a handy Rack app.'

  s.author        = 'John Labovitz'
  s.email         = 'johnl@johnlabovitz.com'
  s.description   = %q{
    DocTree handles a tree of document files that have been marked up in Textile. It includes a handy Rack app.
    It's intended to act as a very simple, small-scale content management system, when you don't need databases
    or dynamic updates.
  }
  s.homepage      = 'http://github.com/jslabovitz/doc-tree'

  s.add_dependency  'rubytree',   '~> 0.8.1'
  s.add_dependency  'RedCloth',   '~> 4.2.7'
  s.add_dependency  'hashstruct', '~> 0.0.2'
  
  s.add_development_dependency 'wrong'
  
  s.files        = Dir.glob('{bin,lib,test}/**/*') + %w(README.markdown)
  s.require_path = 'lib'
end