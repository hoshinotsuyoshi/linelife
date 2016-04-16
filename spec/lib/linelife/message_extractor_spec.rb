describe Linelife::MessageExtractor do
  describe '#do_extract' do
    describe 'returns object which responds to :content_type' do
      include_context 'inbound message is contentType:1'

      it do
        messages = Linelife::MessageExtractor.new.do_extract(json)
        expect(messages.first.content_type).to be :text
      end
    end

    describe 'returns object which responds to :content_type' do
      include_context 'inbound message is contentType:2'

      it do
        messages = Linelife::MessageExtractor.new.do_extract(json)
        expect(messages.first.content_type).to be :image
      end
    end

    describe 'returns object which responds to :from' do
      include_context 'inbound message is contentType:1'

      it do
        messages = Linelife::MessageExtractor.new.do_extract(json)
        expect(messages.first.from).to eq 'ueddddddddddddddddddddddddddddddd'
      end
    end

    describe 'returns object which responds to :message? and :operation?' do
      context 'given normal message' do
        include_context 'inbound message is contentType:1'

        it do
          messages = Linelife::MessageExtractor.new.do_extract(json)
          expect(messages.first).to be_message
          expect(messages.first).not_to be_operation
        end
      end

      context 'given operation' do
        include_context 'inbound message is opType:4'
        it do
          messages = Linelife::MessageExtractor.new.do_extract(json)
          expect(messages.first).not_to be_message
          expect(messages.first).to be_operation
        end
      end
    end

    describe 'returns object which responds to :added_as_friend?' do
      include_context 'inbound message is opType:4'

      it do
        messages = Linelife::MessageExtractor.new.do_extract(json)
        expect(messages.first).to be_added_as_friend
      end
    end
  end

  describe '#extract' do
    it 'calls SignatureValidator#validate! and calls #extract' do
      expect_any_instance_of(Linelife::SignatureValidator).to \
        receive(:validate!).with(signature_inbound: 'sign', string: 'body')
      extractor = Linelife::MessageExtractor.new

      expect(extractor).to \
        receive(:do_extract).with('body')

      extractor.extract(signature_inbound: 'sign', string: 'body')
    end
  end
end
