# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name          = 'doc-tree'
  s.version       = '0.0.1'
  s.summary       = 'Handles a tree of marked-up documents. Includes a handy Rack app.'

  s.author        = 'John Labovitz'
  s.email         = 'johnl@johnlabovitz.com'
  s.description   = %q{
    DocTree handles a tree of marked-up documents. 

    It includes a handy Rack app.

    More documentation is forthcoming.
  }
  s.homepage      = 'http://github.com/jslabovitz/doc-tree'

  s.add_dependency  'rubytree',   '~> 0.8.1'
  s.add_dependency  'RedCloth',   '~> 4.2.7'
  s.add_dependency  'hashstruct', '~> 0.0.1'
  
  s.add_development_dependency 'wrong'
  
  s.required_rubygems_version = '>= 1.6.2'

  s.files        = Dir.glob('{bin,lib,test}/**/*') + %w(README.mdown)
  s.require_path = 'lib'
end