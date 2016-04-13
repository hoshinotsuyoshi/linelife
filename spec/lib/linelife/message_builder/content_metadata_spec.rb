require 'linelife'
include Linelife

describe MessageBuilder::ContentMetadata do
  describe '.create' do
    context 'download_url: is filled' do
      let(:strategy) { { download_url: 'http://image.example.com/img' } }

      it do
        expect(MessageBuilder::MarkupJson).to \
          receive(:create).with(strategy) { { this_is_dummy: 'dummy' } }
        metadata = MessageBuilder::ContentMetadata.create(strategy)
        expect(metadata).to eq(
          ALT_TEXT: 'Please visit our homepage and the item page you wish.',
          DOWNLOAD_URL: 'http://image.example.com/img',
          MARKUP_JSON: '{"this_is_dummy":"dummy"}',
          SPEC_REV: '1'
        )
      end

      context 'alt_text: is filled' do
        let(:strategy) do
          {
            download_url: 'http://image.example.com/img',
            alt_text: 'alt text.'
          }
        end

        it do
          expect(MessageBuilder::MarkupJson).to \
            receive(:create).with(strategy) { { this_is_dummy: 'dummy' } }
          metadata = MessageBuilder::ContentMetadata.create(strategy)
          expect(metadata).to eq(
            ALT_TEXT: 'alt text.',
            DOWNLOAD_URL: 'http://image.example.com/img',
            MARKUP_JSON: '{"this_is_dummy":"dummy"}',
            SPEC_REV: '1'
          )
        end
      end
    end

    context 'download_url: is not filled' do
      let(:strategy) { {} }

      it do
        expect do
          MessageBuilder::ContentMetadata.create(strategy)
        end.to raise_error MessageBuilder::ContentMetadata::Error
      end
    end
  end
end
