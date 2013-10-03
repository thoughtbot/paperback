require 'bundler/setup'
require 'bundler/gem_tasks'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

Cucumber::Rake::Task.new
RSpec::Core::RakeTask.new
Rubocop::RakeTask.new

task :default => %w(spec cucumber rubocop)
