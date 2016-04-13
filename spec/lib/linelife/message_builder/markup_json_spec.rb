describe Linelife::MessageBuilder::MarkupJson do
  describe '.create' do
    let(:strategy) { double(:strategy) }

    it do
      expect(Linelife::MessageBuilder::MarkupJson::Canvas).to \
        receive(:create).with(strategy) { {} }
      expect(Linelife::MessageBuilder::MarkupJson::Images).to \
        receive(:create).with(strategy) { {} }
      expect(Linelife::MessageBuilder::MarkupJson::Actions).to \
        receive(:create).with(strategy) { {} }
      expect(Linelife::MessageBuilder::MarkupJson::Scenes).to \
        receive(:create).with(strategy) { {} }

      markup_json = Linelife::MessageBuilder::MarkupJson.create(strategy)

      expect(markup_json).to eq(
        canvas: {},
        images: {},
        actions: {},
        scenes: {}
      )
    end
  end
end
