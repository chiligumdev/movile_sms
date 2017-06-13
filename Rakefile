require 'rake/testtask'
require 'bundler/gem_tasks'

task default: :spec

task :console do
  exec 'irb -r movile -I ./lib'
end

Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc "Run tests"
task :default => :test
