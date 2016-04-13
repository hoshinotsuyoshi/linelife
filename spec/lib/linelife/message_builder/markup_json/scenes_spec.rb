require 'linelife'
include Linelife

describe MessageBuilder::MarkupJson::Scenes do
  describe '.create' do
    context 'actions is not filled' do
      let(:strategy) { {} }

      it do
        expect do
          MessageBuilder::MarkupJson::Scenes.create(strategy)
        end.to raise_error MessageBuilder::MarkupJson::Scenes::Error
      end
    end

    context 'actions is empty array' do
      let(:strategy) { { actions: [] } }

      it do
        expect do
          MessageBuilder::MarkupJson::Scenes.create(strategy)
        end.to raise_error MessageBuilder::MarkupJson::Scenes::Error
      end
    end

    context 'actions is filled' do
      let(:strategy) do
        {
          actions: [
            { name: :action1 },
            { name: :action2 }
          ]
        }
      end

      it do
        actions = MessageBuilder::MarkupJson::Scenes.create(strategy)
        expect(actions).to eq(
          scene1: {
            draws: [
              { image: 'image1', x: 0, y: 0, w: 1040, h: 1040 }
            ],
            listeners: [
              { type: 'touch', params: [0, 0, 1040, 520], action: 'action1' },
              { type: 'touch', params: [0, 520, 1040, 520], action: 'action2' }
            ]
          }
        )
      end
    end

    context 'actions is filled with listener_params' do
      let(:strategy) do
        {
          actions: [
            {
              name: :action1,
              listener_params: [0, 0, 520, 1040]
            },
            {
              name: :action2,
              listener_params: [520, 0, 520, 1040]
            }
          ]
        }
      end

      it do
        actions = MessageBuilder::MarkupJson::Scenes.create(strategy)
        expect(actions).to eq(
          scene1: {
            draws: [
              { image: 'image1', x: 0, y: 0, w: 1040, h: 1040 }
            ],
            listeners: [
              { type: 'touch', params: [0, 0, 520, 1040], action: 'action1' },
              { type: 'touch', params: [520, 0, 520, 1040], action: 'action2' }
            ]
          }
        )
      end
    end

    context 'actions is filled with listener_params and width-height is filled' do
      context 'actions size is 2' do
        let(:strategy) do
          {
            actions: [
              { name: :action1 },
              { name: :action2 }
            ],
            width: 700,
            height: 800
          }
        end

        it do
          actions = MessageBuilder::MarkupJson::Scenes.create(strategy)
          expect(actions).to eq(
            scene1: {
              draws: [
                { image: 'image1', x: 0, y: 0, w: 700, h: 800 }
              ],
              listeners: [
                { type: 'touch', params: [0, 0, 700, 400], action: 'action1' },
                { type: 'touch', params: [0, 400, 700, 400], action: 'action2' }
              ]
            }
          )
        end
      end

      context 'actions size is 1' do
        let(:strategy) do
          {
            actions: [
              { name: :action1 }
            ],
            width: 700,
            height: 800
          }
        end

        it do
          actions = MessageBuilder::MarkupJson::Scenes.create(strategy)
          expect(actions).to eq(
            scene1: {
              draws: [
                { image: 'image1', x: 0, y: 0, w: 700, h: 800 }
              ],
              listeners: [
                { type: 'touch', params: [0, 0, 700, 800], action: 'action1' }
              ]
            }
          )
        end
      end
    end
  end
end
