require 'linelife'
include Linelife

describe MessageBuilder::MarkupJson do
  describe '.create' do
    let(:strategy) { double(:strategy) }

    it do
      expect(MessageBuilder::MarkupJson::Canvas).to receive(:create).with(strategy) { {} }
      expect(MessageBuilder::MarkupJson::Images).to receive(:create).with(strategy) { {} }
      expect(MessageBuilder::MarkupJson::Actions).to receive(:create).with(strategy) { {} }
      expect(MessageBuilder::MarkupJson::Scenes).to receive(:create).with(strategy) { {} }
      markup_json = MessageBuilder::MarkupJson.create(strategy)
      expect(markup_json).to eq(
        canvas: {},
        images: {},
        actions: {},
        scenes: {}
      )
    end
  end
end
