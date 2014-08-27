require 'bundler/audit/cli'
require 'bundler/gem_tasks'
require 'bundler/setup'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

Cucumber::Rake::Task.new
RSpec::Core::RakeTask.new
RuboCop::RakeTask.new

namespace :bundler do
  task :audit do
    %w(update check).each do |command|
      Bundler::Audit::CLI.start [command]
    end
  end
end

task default: %w(bundler:audit rubocop spec cucumber)
