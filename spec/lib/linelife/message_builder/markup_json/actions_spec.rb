require 'linelife'
include Linelife

describe MessageBuilder::MarkupJson::Actions do
  describe '.create' do
    context 'actions is not filled' do
      let(:strategy) { {} }

      it do
        expect do
          MessageBuilder::MarkupJson::Actions.create(strategy)
        end.to raise_error MessageBuilder::MarkupJson::Actions::Error
      end
    end

    context 'actions is empty array' do
      let(:strategy) { { actions: [] } }

      it do
        expect do
          MessageBuilder::MarkupJson::Actions.create(strategy)
        end.to raise_error MessageBuilder::MarkupJson::Actions::Error
      end
    end

    context 'actions is filled' do
      let(:strategy) do
        {
          actions: [
            { name: :action1, link_uri: 'https://example.com/index.html' },
            { name: :action2, link_uri: 'https://example.com/items/1' }
          ]
        }
      end

      it do
        actions = MessageBuilder::MarkupJson::Actions.create(strategy)
        expect(actions).to eq(
          action1: {
            type: 'web',
            text: '',
            params: { linkUri: 'https://example.com/index.html' }
          },
          action2: {
            type: 'web',
            text: '',
            params: { linkUri: 'https://example.com/items/1' }
          }
        )
      end
    end
  end
end
