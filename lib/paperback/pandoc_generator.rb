module Paperback
  class PandocGenerator
    def initialize(package)
      @package = package
    end

    def generate(format, args)
      args.push(
        "--smart",
        "--output=#{package.target(format)}",
        package.target(:md)
      )

      Dir.chdir Paperback.target_root do
        pandoc_runner = Paperback::PandocRunner.new(args.join(" "))
        pandoc_runner.run
      end
    end

    private

    attr_reader :package
  end
end
