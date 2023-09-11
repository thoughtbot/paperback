require "terrapin"

module Paperback
  class Pandoc
    CLI_DEPENDENCY = Gem::Dependency.new("pandoc", ">= 1.11.1")

    module Regex
      CLI_VERSION = /pandoc (?<version>.*)/
    end

    def initialize(package)
      @package = package
    end

    def generate(format, args)
      unless cli_dependency_match?
        fail "Please install #{CLI_DEPENDENCY}"
      end

      args.push(
        "--from=markdown+smart",
        "--output=#{package.target(format)}",
        package.target(:md)
      )

      Dir.chdir Paperback.target_root do
        run args.join(" ")
      end
    end

    private

    attr_reader :package

    def cli_dependency_match?
      match_data = Regex::CLI_VERSION.match(run("--version"))
      CLI_DEPENDENCY.match? CLI_DEPENDENCY.name, match_data[:version]
    end

    def run(params)
      Terrapin::CommandLine.new(CLI_DEPENDENCY.name, params).run
    end
  end
end
