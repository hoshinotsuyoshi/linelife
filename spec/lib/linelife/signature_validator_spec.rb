describe Linelife::SignatureValidator do
  describe '#validate!' do
    let(:body) { StringIO.new(string).tap(&:read) }
    let(:string) { 'this_is_message_body' }
    let(:channel_secret) { 'this_is_channel_secret' }

    context 'given correct "X-Line-Channelsecret" header' do
      let(:correct_signatrue) { 'MLS0KXJq4bcnxCOwLhz+Hrr1LiM/Txqaz4oOeAEkp5c=' }

      it do
        expect_any_instance_of(Linelife::SignatureValidator).to \
          receive(:channel_secret) { channel_secret }
        expect do
          Linelife::SignatureValidator.new.validate!(
            string: string,
            signature_inbound: correct_signatrue
          )
        end.not_to raise_error
      end
    end

    context 'given incorrect "X-Line-Channelsecret" header' do
      let(:wrong_signatrue) { 'wrong wrong wrong wrong=' }

      it do
        expect_any_instance_of(Linelife::SignatureValidator).to \
          receive(:channel_secret) { channel_secret }
        expect do
          Linelife::SignatureValidator.new.validate!(
            string: string,
            signature_inbound: wrong_signatrue
          )
        end.to raise_error Linelife::SignatureValidator::Error
      end
    end
  end
end
