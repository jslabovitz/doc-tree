$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'doc-tree'
 
task :build do
  system "gem build doc-tree.gemspec"
end
 
task :release => :build do
  system "gem push doc-tree-#{DocTree::VERSION}"
end