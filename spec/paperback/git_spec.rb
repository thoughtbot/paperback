describe Paperback::Git do
  describe '.origin_url' do
    it 'returns the origin url' do
      expected = 'http://example.com/foo/bar.git'
      command_line = stub_command_line("#{expected}\n")

      actual = Paperback::Git.origin_url

      expect_git 'config --get remote.origin.url'
      expect(command_line).to have_received(:run)
      expect(actual).to eq(expected)
    end
  end

  describe '.repository_name' do
    it 'returns the repository name' do
      expected = 'bar'
      origin_url = "http://example.com/foo/#{expected}.git"
      stub_command_line "#{origin_url}\n"

      actual = Paperback::Git.repository_name

      expect(actual).to eq(expected)
    end
  end

  describe '.show_example' do
    def example
      <<-EOS.strip_heredoc
          module Foo
            class Bar
            end
          end
      EOS
    end

    def expected
      <<-EOS.strip_heredoc
        module Foo
          class Bar
          end
        end
      EOS
    end

    context 'without range' do
      it 'runs git-show' do
        command_line = stub_command_line(example)

        actual = Paperback::Git.show_example('example.rb', 'a1b2c3')

        expect_git 'show a1b2c3:example_app/example.rb'
        expect(command_line).to have_received(:run)
        expect(actual).to eq(expected)
      end
    end

    context 'with range' do
      it 'pipes git-show into sed' do
        command_line = stub_command_line(example)

        actual = Paperback::Git.show_example('example.rb', 'a1b2c3', '1,2')

        expect_git 'show a1b2c3:example_app/example.rb | sed -n 1,2p'
        expect(command_line).to have_received(:run)
        expect(actual).to eq(expected)
      end
    end
  end

  def expect_git(subcommand)
    expect(Cocaine::CommandLine).to have_received(:new)
      .with("git #{subcommand}", '', expected_outcodes: [0, 1])
  end
end
