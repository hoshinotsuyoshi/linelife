module Linelife
  module Message
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
        when 2
          :image
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
