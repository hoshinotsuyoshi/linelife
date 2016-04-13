describe Linelife::MessageExtractor do
  describe '#content_type' do
    include_context 'inbound message is contentType:1'

    it do
      messages = Linelife::MessageExtractor.new.do_extract(json)
      expect(messages.first.content_type).to be :text
    end
  end

  describe '#from' do
    include_context 'inbound message is contentType:1'

    it do
      messages = Linelife::MessageExtractor.new.do_extract(json)
      expect(messages.first.from).to eq 'ueddddddddddddddddddddddddddddddd'
    end
  end

  describe '#operation? and #message?' do
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

  describe '#added_as_friend?' do
    include_context 'inbound message is opType:4'

    it do
      messages = Linelife::MessageExtractor.new.do_extract(json)
      expect(messages.first).to be_added_as_friend
    end
  end
end
