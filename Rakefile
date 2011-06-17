$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'hashstruct'
 
task :build do
  system "gem build hashstruct.gemspec"
end
 
task :release => :build do
  system "gem push hashstruct-#{HashStruct::VERSION}"
end