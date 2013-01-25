module CocaineMacros
  def stub_command_line(output, exit_status = 0)
    command_line = mock('Cocaine::CommandLine')
    command_line.stubs(:exit_status).returns exit_status
    command_line.stubs(:run).returns output
    Cocaine::CommandLine.stubs(:new).returns command_line
    command_line
  end
end

RSpec.configure do |config|
  config.include CocaineMacros
end
