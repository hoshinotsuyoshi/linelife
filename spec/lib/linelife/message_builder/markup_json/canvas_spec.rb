require 'linelife'
include Linelife

describe MessageBuilder::MarkupJson::Canvas do
  describe '.create' do
    context 'canvas_height is not filled' do
      let(:strategy) { {} }

      it do
        canvas = MessageBuilder::MarkupJson::Canvas.create(strategy)
        expect(canvas).to eq(
          height: 1040,
          initialScene: 'scene1',
          width: 1040
        )
      end
    end

    context 'canvas_height is filled' do
      let(:strategy) { { canvas_height: 1555 } }

      it do
        canvas = MessageBuilder::MarkupJson::Canvas.create(strategy)
        expect(canvas).to eq(
          height: 1555,
          initialScene: 'scene1',
          width: 1040
        )
      end
    end
  end
end
