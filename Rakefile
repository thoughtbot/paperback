require "bundler/audit/cli"
require "cucumber/rake/task"
require "rspec/core/rake_task"
require "standard/rake"

Cucumber::Rake::Task.new
RSpec::Core::RakeTask.new

namespace :bundler do
  task :audit do
    %w[update check].each do |command|
      Bundler::Audit::CLI.start [command]
    end
  end
end

task default: %w[bundler:audit standard spec cucumber]
