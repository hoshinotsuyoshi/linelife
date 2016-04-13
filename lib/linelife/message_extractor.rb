require 'json'
require 'linelife/message/inbound'
require 'linelife/signature_validator'

module Linelife
  #
  # Build Message::Inbound from request
  #
  class MessageExtractor
    extend Forwardable

    def_delegators :validator, :validate!

    def validator
      SignatureValidator.new
    end

    def do_extract(string)
      hash = JSON.parse(string)
      hash['result'].map do |message|
        Message::Inbound.new(message)
      end
    end

    def extract(request)
      string = request.body.read
      validate!(request: request, string: string)
      do_extract(string)
    end
  end
end
