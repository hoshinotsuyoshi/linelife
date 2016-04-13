describe Linelife::Message do
  describe '.new' do
    context 'given {"a":"b"}' do
      subject do
        Linelife::Message.new('a' => 'b')
      end

      before do
        expect_any_instance_of(Linelife::Message).to \
          receive(:line_channel_id) { 'channel_id' }
        expect_any_instance_of(Linelife::Message).to \
          receive(:line_channel_secret) { 'channel_secret' }
        expect_any_instance_of(Linelife::Message).to \
          receive(:line_channel_mid) { 'channel_mid' }
      end

      it { expect(subject['Content-Length']).to eq '9' }
      it do
        expect(subject['Content-Type']).to eq 'application/json; charset=UTF-8'
      end
      it { expect(subject['X-Line-Channelid']).to eq 'channel_id' }
      it { expect(subject['X-Line-Channelsecret']).to eq 'channel_secret' }
      it { expect(subject['X-Line-Trusted-User-With-Acl']).to eq 'channel_mid' }
      it { expect(subject.body).to eq '{"a":"b"}' }
      it { expect(subject.path).to eq '/v1/events' }
    end
  end
end
