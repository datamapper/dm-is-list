spec_defaults = lambda do |spec|
  spec.pattern    = 'spec/**/*_spec.rb'
  spec.libs      << 'lib' << 'spec'
  spec.spec_opts << '--options' << 'spec/spec.opts'
end

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
