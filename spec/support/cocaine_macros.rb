module TerrapinMacros
  def stub_command_line(output = "", exit_status = 0)
    command_line = double(
      Terrapin::CommandLine,
      exit_status: exit_status,
      run: output
    )

    allow(Terrapin::CommandLine).to receive(:new) { command_line }
    command_line
  end
end

RSpec.configure do |config|
  config.include TerrapinMacros
end
