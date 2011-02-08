require 'bundler'
require 'rake/testtask'

Bundler::GemHelper.install_tasks

Rake::TestTask.new do |task|
  task.verbose = true
  task.libs << 'test'
end

task :default => :test

