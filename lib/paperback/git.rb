require "active_support/core_ext/string/strip"
require "cocaine"

module Paperback
  class Git
    attr_accessor :exit_status, :output

    def initialize(subcommand)
      @subcommand = subcommand
    end

    def self.origin_url
      git = new("config --get remote.origin.url")
      output = git.run.output.strip

      if output.empty?
        fail "No origin remote present."
      end

      output
    end

    def self.repository_name
      File.basename(Dir.pwd)
    end

    def run
      full_command = "git #{@subcommand}"
      options = { expected_outcodes: [0, 1] }
      command_line = Cocaine::CommandLine.new(full_command, "", options)
      self.output = command_line.run
      self.exit_status = command_line.exit_status
      self
    end

    def self.show_example(path, ref, range = nil)
      subcommand = "show #{ref}:example_app/#{path}"

      if range
        subcommand << " | sed -n #{range}p"
      end

      git = new(subcommand)
      git.run.output.strip_heredoc
    end
  end
end
