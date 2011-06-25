task :test do
  ruby 'test/test_doctree.rb'
end
 
task :build => :test do
  system 'gem build doc-tree.gemspec'
end

task :release => :build do
  system "gem push doc-tree-#{DocTree::VERSION}"
end