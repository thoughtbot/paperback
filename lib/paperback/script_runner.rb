require 'tempfile'

module Paperback
  class ScriptRunner
    ECHO_TYPE = '$'
    OUTPUT_TYPE = '!'
    SILENT_TYPE = '#'

    module Regex
      SCRIPT = %r{
        \A
        `
        (?<type>[#{ECHO_TYPE}#{OUTPUT_TYPE}#{SILENT_TYPE}])
        \s+
        (?<command>.*)
        \n?
        \Z
      }x
    end

    def initialize(input)
      @input = input
    end

    def output
      output = []
      remainder = input.lines

      while remainder.any?
        script = remainder.take_while { |line| line =~ Regex::SCRIPT }
        output += Script.new(script).output
        remainder = remainder.drop(script.size)

        new_output = remainder.take_while { |line| line !~ Regex::SCRIPT }
        output += new_output
        remainder = remainder.drop(new_output.size)
      end

      output.join
    end

    protected

    attr_reader :input

    class Script
      def initialize(input_lines)
        @input_lines = input_lines
      end

      def output
        if input_lines.any?
          ["```\n", generated_output, "```\n"]
        else
          []
        end
      end

      protected

      attr_reader :input_lines

      private

      def generated_output
        `#{script_file.path}`
      end

      def script_file
        @script_file ||= Tempfile.new('script').tap do |file|
          file << "#!/bin/sh\n\n"
          file << script
          file.close
          File.chmod(0744, file.path)
        end
      end

      def script
        input_lines.map do |line|
          match = Regex::SCRIPT.match(line)
          case match[:type]
          when ECHO_TYPE
            "echo '$ #{match[:command]}'\n#{match[:command]}\n"
          when OUTPUT_TYPE
            "#{match[:command]}\n"
          when SILENT_TYPE
            "#{silence(match[:command])}\n"
          end
        end.join
      end

      def silence(command)
        if command =~ />/
          command
        else
          "#{command} > /dev/null"
        end
      end
    end
  end
end
