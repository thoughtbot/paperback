require "spec_helper"

describe Paperback::ScriptRunner do
  context "#output" do
    context "with no embedded scripts in the input" do
      it "returns the input" do
        input = "Hello world\n"
        runner = described_class.new(input)

        expect(runner.output).to eq input
      end
    end

    context "with an embedded script" do
      it "returns the input with the embedded script replaced by its output" do
        input = strip_indentation(<<-INPUT)
          Hello world

          `$ echo Scripted
        INPUT
        runner = described_class.new(input)

        expect(runner.output).to eq strip_indentation(<<-OUTPUT)
          Hello world

          ```
          $ echo Scripted
          Scripted
          ```
        OUTPUT
      end
    end

    context "with multiple embedded scripts" do
      it "returns the input with all the scripts replaced by their output" do
        input = strip_indentation(<<-INPUT)
          Hello

          `! echo First

          Goodbye

          `! echo Second
        INPUT
        runner = described_class.new(input)

        expect(runner.output).to eq strip_indentation(<<-OUTPUT)
          Hello

          ```
          First
          ```

          Goodbye

          ```
          Second
          ```
        OUTPUT
      end
    end
  end

  def strip_indentation(string)
    string.gsub(/\n\s+/, "\n")
  end
end
