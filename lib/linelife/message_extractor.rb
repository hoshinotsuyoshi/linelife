require 'forwardable'
require 'json'
require 'linelife/message/inbound'
require 'linelife/signature_validator'

module Linelife
  #
  # Build Message::Inbound from request
  #
  class MessageExtractor
    extend Forwardable

    def_delegator :validator, :validate!

    def do_extract(string)
      hash = JSON.parse(string)
      hash['result'].map do |message|
        Message::Inbound.new(message)
      end
    end

    def extract(signature_inbound:, string:)
      validate!(signature_inbound: signature_inbound, string: string)
      do_extract(string)
    end

    private

    def validator
      SignatureValidator.new
    end
  end
end
