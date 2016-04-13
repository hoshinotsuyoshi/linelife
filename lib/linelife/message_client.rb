require 'net/http'
require 'uri'

module Linelife
  #
  # client wrapping Net::HTTP(and .Proxy)
  #
  class MessageClient
    def initialize
      @client = build_client
    end

    attr_reader :client

    def send(message)
      client.request(message)
    end

    private

    def build_client
      proxy_class.new(endpoint_uri.host, endpoint_uri.port).tap do |http|
        http.use_ssl = true
      end
    end

    def endpoint_uri
      URI('https://trialbot-api.line.me/v1/events')
    end

    def proxy_class
      if proxy_url
        uri = URI(proxy_url)
        Net::HTTP.Proxy(uri.host, uri.port, uri.user, uri.password)
      else
        Net::HTTP
      end
    end

    def proxy_url
      ENV['FIXIE_URL']
    end
  end
end
