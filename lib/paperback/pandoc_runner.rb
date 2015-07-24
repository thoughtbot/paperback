require "cocaine"

module Paperback
  class PandocRunner
    CLI_DEPENDENCY = Gem::Dependency.new("pandoc", ">= 1.11.1")

    module Regex
      CLI_VERSION = /pandoc (?<version>.*)/
    end

    def initialize(arguments)
      @arguments = arguments
    end

    def run
      unless cli_dependency_match?
        fail "Please install #{CLI_DEPENDENCY}"
      end

      run_with_cocaine(arguments)
    end

    private

    attr_reader :arguments

    def cli_dependency_match?
      match_data = Regex::CLI_VERSION.match(run_with_cocaine("--version"))
      CLI_DEPENDENCY.match? CLI_DEPENDENCY.name, match_data[:version]
    end

    def run_with_cocaine(params)
      Cocaine::CommandLine.new(pandoc_command, params).run
    end

    def pandoc_command
      CLI_DEPENDENCY.name
    end
  end
end
