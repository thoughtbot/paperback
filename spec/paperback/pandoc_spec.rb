describe Paperback::Pandoc do
  describe '#to_html' do
    before do
      package = double(Paperback::Package).as_null_object
      @pandoc = Paperback::Pandoc.new(package)
    end

    context 'with an unsupported version of pandoc' do
      it 'raises an error' do
        stub_command_line 'pandoc 1.11.0'

        expect { @pandoc.to_html }.to raise_error(RuntimeError)
      end
    end

    context 'with a supported version of pandoc' do
      it 'does not raise an error' do
        stub_command_line 'pandoc 1.11.2'

        expect { @pandoc.to_html }.not_to raise_error
      end
    end
  end
end
