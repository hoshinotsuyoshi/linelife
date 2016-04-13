require 'json'
require 'linelife/message_builder/markup_json'

module Linelife
  class MessageBuilder
    #
    # contentMetadata.
    #
    class ContentMetadata < ::Hash
      class Error < ::StandardError; end

      def self.create(strategy)
        # [type].
        # [description].
        hash = {
          # String
          # URL of image which is on your server.
          DOWNLOAD_URL: strategy[:download_url] || raise(Error, 'download_url is missing'),
          # String
          # Fixed "1".
          SPEC_REV: '1',
          # String
          # Alternative string displayed on low-level devices.
          ALT_TEXT: strategy[:alt_text] || 'Please visit our homepage and the item page you wish.',
          # String
          # Escaped string of the JSON string representing the rich message object.
          MARKUP_JSON: MarkupJson.create(strategy).to_json
        }
        new.replace(hash)
      end
    end
  end
end
