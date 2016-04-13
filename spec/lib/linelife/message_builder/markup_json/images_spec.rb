describe Linelife::MessageBuilder::MarkupJson::Images do
  describe '.create' do
    context 'image_image1_h is not filled' do
      let(:strategy) { {} }

      it do
        canvas = Linelife::MessageBuilder::MarkupJson::Images.create(strategy)
        expect(canvas).to eq(
          image1: { x: 0, y: 0, w: 1040, h: 1040 }
        )
      end
    end

    context 'image_image1_h is filled' do
      let(:strategy) { { image_image1_h: 1555 } }

      it do
        canvas = Linelife::MessageBuilder::MarkupJson::Images.create(strategy)
        expect(canvas).to eq(
          image1: { x: 0, y: 0, w: 1040, h: 1555 }
        )
      end
    end
  end
end
