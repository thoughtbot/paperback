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
        input = "Hello world\n\n`$ echo Scripted\n"
        runner = described_class.new(input)

        expect(runner.output).
          to eq "Hello world\n\n```\n$ echo Scripted\nScripted\n```\n"
      end
    end

    context "with multiple embedded scripts" do
      it "returns the input with all the scripts replaced by their output" do
        input = "Hello\n\n`! echo First\n\nGoodbye\n\n`! echo Second"
        runner = described_class.new(input)

        expect(runner.output).
          to eq "Hello\n\n```\nFirst\n```\n\nGoodbye\n\n```\nSecond\n```\n"
      end
    end
  end
end
