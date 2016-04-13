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
          DOWNLOAD_URL: strategy[:download_url] || missing_download_url,
          # String
          # Fixed "1".
          SPEC_REV: '1',
          # String
          # Alternative string displayed on low-level devices.
          ALT_TEXT: strategy[:alt_text] || default_alt_text,
          # String
          # JSON string representing the rich message object.
          MARKUP_JSON: MarkupJson.create(strategy).to_json
        }
        new.replace(hash)
      end

      def self.missing_download_url
        raise(Error, 'download_url is missing')
      end

      private_class_method :missing_download_url

      def self.default_alt_text
        'Please visit our homepage and the item page you wish.'
      end

      private_class_method :default_alt_text
    end
  end
end
