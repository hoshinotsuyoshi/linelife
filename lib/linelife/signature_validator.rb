require 'base64'
require 'openssl'

module Linelife
  #
  # validator for signature
  # see https://developers.line.me/bot-api/getting-started-with-bot-api-trial#prerequisite
  #
  class SignatureValidator
    class Error < ::StandardError; end

    def validate!(signature_inbound:, string:)
      signature = calculate_signature(string)
      return if signature == signature_inbound
      raise Error
    end

    private

    def channel_secret
      ENV['LINE_CHANNEL_SECRET']
    end

    def calculate_signature(string)
      hash = OpenSSL::HMAC.digest(
        OpenSSL::Digest::SHA256.new,
        channel_secret,
        string
      )

      Base64.strict_encode64(hash)
    end
  end
end
