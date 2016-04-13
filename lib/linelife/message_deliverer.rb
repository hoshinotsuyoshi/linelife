require 'net/http'
require 'uri'

module Linelife
  #
  # deliverer wrapping Net::HTTP(and .Proxy)
  #
  class MessageDeliverer
    def initialize
      @deliverer = build_deliverer
    end

    attr_reader :deliverer

    def send(message)
      deliverer.request(message)
    end

    private

    def build_deliverer
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
