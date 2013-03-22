require 'cocaine'
require 'hub'

module Paperback
  class Hub
    extend ::Hub::Context

    def self.checkout(pull_request_id)
      hub 'checkout', "#{current_project.web_url}/pull/#{pull_request_id}"
    end

    def self.project_name
      current_project.name
    end

    private

    def self.hub(*args)
      ::Hub::Runner.new(*args).args.commands.each do |command|
        Cocaine::CommandLine.new(command).run
      end
    end
  end
end
