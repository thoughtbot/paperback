module Paperback
  class Configuration
    attr_writer :git_command

    def git_command
      ENV['GIT_COMMAND'] || @git_command || 'git'
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
