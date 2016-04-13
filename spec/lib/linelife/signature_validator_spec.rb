require 'linelife'
include Linelife

describe SignatureValidator do
  describe '#validate!' do
    let(:request) { double(:request, body: body, env: env) }
    let(:body) { StringIO.new(string).tap(&:read) }
    let(:string) { 'this_is_message_body' }
    let(:channel_secret) { 'this_is_channel_secret' }

    context 'given correct "X-Line-Channelsecret" header' do
      let(:correct_signatrue) { 'MLS0KXJq4bcnxCOwLhz+Hrr1LiM/Txqaz4oOeAEkp5c=' }
      let(:env) { { 'HTTP_X_LINE_CHANNELSIGNATURE' => correct_signatrue } }

      it do
        expect_any_instance_of(SignatureValidator).to \
          receive(:channel_secret) { channel_secret }
        expect do
          SignatureValidator.new.validate!(string: string, request: request)
        end.not_to raise_error
      end
    end

    context 'given incorrect "X-Line-Channelsecret" header' do
      let(:wrong_signatrue) { 'wrong wrong wrong wrong=' }
      let(:env) { { 'HTTP_X_LINE_CHANNELSIGNATURE' => wrong_signatrue } }

      it do
        expect_any_instance_of(SignatureValidator).to \
          receive(:channel_secret) { channel_secret }
        expect do
          SignatureValidator.new.validate!(string: string, request: request)
        end.to raise_error Linelife::SignatureValidator::Error
      end
    end
  end
end
