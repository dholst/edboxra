require 'bundler'
require 'rake/testtask'

Bundler::GemHelper.install_tasks

Rake::TestTask.new do |task|
  task.libs << 'test/unit'
  task.libs << 'test/unit/helpers'
  task.test_files = FileList['test/unit/**/test*.rb']
end

Rake::TestTask.new('test:integration') do |task|
  task.libs << 'test/integration'
  task.test_files = FileList['test/integration/**/test*.rb']
end

task :default => :test

