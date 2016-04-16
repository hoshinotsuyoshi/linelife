describe Linelife::Message::Outbound do
  describe '.new' do
    context 'given {"a":"あ"}' do
      subject do
        Linelife::Message::Outbound.new('a' => 'あ')
      end

      before do
        expect_any_instance_of(Linelife::Message::Outbound).to \
          receive(:line_channel_id) { 'channel_id' }
        expect_any_instance_of(Linelife::Message::Outbound).to \
          receive(:line_channel_secret) { 'channel_secret' }
        expect_any_instance_of(Linelife::Message::Outbound).to \
          receive(:line_channel_mid) { 'channel_mid' }
      end

      it { expect(subject['Content-Length']).to eq '11' }
      it do
        expect(subject['Content-Type']).to eq 'application/json; charset=UTF-8'
      end
      it { expect(subject['X-Line-Channelid']).to eq 'channel_id' }
      it { expect(subject['X-Line-Channelsecret']).to eq 'channel_secret' }
      it { expect(subject['X-Line-Trusted-User-With-Acl']).to eq 'channel_mid' }
      it { expect(subject.body).to eq '{"a":"あ"}' }
      it { expect(subject.path).to eq '/v1/events' }
      it { expect(subject).to be_a Net::HTTP::Post }
    end
  end
end
