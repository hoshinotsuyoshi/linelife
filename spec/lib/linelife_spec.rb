describe Linelife do
  describe '.send_message' do
    it do
      content_hash = { a: 'b' }

      expect_any_instance_of(Linelife::Message).to \
        receive(:line_channel_id) { 'channel_id' }
      expect_any_instance_of(Linelife::Message).to \
        receive(:line_channel_secret) { 'channel_secret' }
      expect_any_instance_of(Linelife::Message).to \
        receive(:line_channel_mid) { 'channel_mid' }

      stub = stub_request(:post, 'https://trialbot-api.line.me/v1/events')
             .with(
               body: '{"a":"b"}',
               headers: {
                 'Accept' => '*/*',
                 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                 'Content-Length' => '9',
                 'Content-Type' => 'application/json; charset=UTF-8',
                 'User-Agent' => 'Ruby',
                 'X-Line-Channelid' => 'channel_id',
                 'X-Line-Channelsecret' => 'channel_secret',
                 'X-Line-Trusted-User-With-Acl' => 'channel_mid'
               }
             ).to_return(status: 200, body: '', headers: {})

      Linelife.send_message(content_hash)

      expect(stub).to have_been_requested.once
    end
  end
end
