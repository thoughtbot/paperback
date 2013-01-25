require 'spec_helper'

describe Paperback::Configuration do
  describe '#git_command' do
    context 'when a configuration is not specified' do
      it do
        expect(Paperback.configuration.git_command).to eq('git')
      end
    end

    context 'when a GIT_COMMAND env var is specified' do
      before do
        ENV['GIT_COMMAND'] = 'foo'
      end

      after do
        ENV['GIT_COMMAND'] = nil
      end

      it do
        expect(Paperback.configuration.git_command).to eq('foo')
      end
    end

    context 'when a git_command is specified' do
      before do
        Paperback.configure do |config|
          config.git_command = 'foo'
        end
      end

      after do
        Paperback.configure do |config|
          config.git_command = nil
        end
      end

      it do
        expect(Paperback.configuration.git_command).to eq('foo')
      end
    end

    context 'when both GIT_COMMAND and git_command are specified' do
      before do
        ENV['GIT_COMMAND'] = 'foo'

        Paperback.configure do |config|
          config.git_command = 'bar'
        end
      end

      after do
        ENV['GIT_COMMAND'] = nil

        Paperback.configure do |config|
          config.git_command = nil
        end
      end

      it do
        expect(Paperback.configuration.git_command).to eq('foo')
      end
    end
  end
end
