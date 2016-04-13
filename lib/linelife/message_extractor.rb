require 'json'
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

  class Message
    #
    # inbound message
    #
    class Inbound
      TRIAL_API_MESSAGE_EVENT_TYPE = '138311609000106303'.freeze
      TRIAL_API_OPERATION_EVENT_TYPE = '138311609100106403'.freeze

      def initialize(hash)
        @message = hash
      end
      attr_reader :message

      def event_type
        message['eventType']
      end

      def message?
        event_type == TRIAL_API_MESSAGE_EVENT_TYPE
      end

      def operation?
        event_type == TRIAL_API_OPERATION_EVENT_TYPE
      end

      def added_as_friend?
        operation? && (content['opType'] == 4)
      end

      # https://developers.line.me/bot-api/api-reference#receiving_messages_contenttype
      def content_type
        case content['contentType']
        when 1
          :text
        end
      end

      def content
        message['content']
      end

      def from
        content['from']
      end

      def text
        content['text']
      end
    end
  end
end