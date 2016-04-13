require 'linelife'
include Linelife

describe MessageBuilder do
  describe '#build' do
    include_context 'outbound expected message is contentType:1'

    it do
      to = 'ufffff'
      text = 'テスト送信'
      message = MessageBuilder.new.build(to: to, text: text)
      expect(message).to eq(expected_hash)
    end
  end

  describe '#build_rich' do
    include_context 'outbound expected message is contentType:12'

    it do
      to = 'ufffff'
      strategy = {
        download_url: 'https://images.example.com/img',
        actions: [
          { name: :openHomepage, link_uri: 'https://twitter.com/hoppiestar', text: 'Open our homepage.' },
          { name: :showItem, link_uri: 'https://twitter.com/hoppiestar/status/719483889526288384', text: 'Show item.' }
        ]
      }
      message = MessageBuilder.new.build_rich(to: to, strategy: strategy)
      expect(message).to eq(expected_hash)
    end
  end
end
