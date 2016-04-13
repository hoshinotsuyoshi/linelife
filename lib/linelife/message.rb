require 'net/http'
require 'json'
require 'uri'

module Linelife
  #
  # messages to send to bot-api
  #
  class Message < Net::HTTP::Post
    def initialize(hash)
      super(endpoint_uri.path)
      json = hash.to_json
      basic_header.each do |k, v|
        self[k] = v
      end
      self['Content-Length'] = json.size.to_s
      self.body = json
    end

    private

    def basic_header
      {
        'Content-Type' => 'application/json; charset=UTF-8',
        'X-Line-ChannelID' => line_channel_id,
        'X-Line-ChannelSecret' => line_channel_secret,
        'X-Line-Trusted-User-With-ACL' => line_channel_mid
      }
    end

    def endpoint_uri
      URI('https://trialbot-api.line.me/v1/events')
    end

    def line_channel_id
      ENV['LINE_CHANNEL_ID']
    end

    def line_channel_secret
      ENV['LINE_CHANNEL_SECRET']
    end

    def line_channel_mid
      ENV['LINE_CHANNEL_MID']
    end
  end
end
