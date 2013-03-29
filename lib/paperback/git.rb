require 'active_support/core_ext/string/strip'
require 'cocaine'

module Paperback
  class Git
    attr_accessor :exit_status, :output

    def initialize(subcommand)
      @command = "git #{subcommand}"
    end

    def self.dirty?
      run('diff --quiet --ignore-submodules HEAD').exit_status == 1
    end

    def run
      options = { expected_outcodes: [0, 1] }
      command_line = Cocaine::CommandLine.new(@command, '', options)
      self.output = command_line.run
      self.exit_status = command_line.exit_status
      self
    end

    def self.show_example(path, ref, range = nil)
      subcommand = "show #{ref}:example_app/#{path}"

      if range
        subcommand << " | sed -n #{range}p"
      end

      run(subcommand).output.strip_heredoc
    end

    private

    def self.run(subcommand)
      Git.new(subcommand).run
    end
  end
end
