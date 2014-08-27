require 'paperback/cli'

describe Paperback::CLI do
  describe '#release' do
    it 'builds and syncs with S3' do
      @cli = Paperback::CLI.new
      allow(@cli).to receive(:build)
      allow(AssetSync).to receive(:sync)

      @cli.release

      expect(@cli).to have_received(:build)
      expect(AssetSync).to have_received(:sync)
    end
  end
end
