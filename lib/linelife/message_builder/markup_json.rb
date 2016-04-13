require 'linelife/message_builder/markup_json/actions'
require 'linelife/message_builder/markup_json/canvas'
require 'linelife/message_builder/markup_json/images'
require 'linelife/message_builder/markup_json/scenes'

module Linelife
  class MessageBuilder
    # https://developers.line.me/businessconnect/api-reference#sending_rich_content_message
    #
    # Build MARKUP_JSON.
    # .create returns hash
    #
    class MarkupJson < ::Hash
      class Error < ::StandardError; end
      def self.create(strategy)
        hash = {
          canvas: Canvas.create(strategy),
          images: Images.create(strategy),
          actions: Actions.create(strategy),
          scenes: Scenes.create(strategy)
        }
        new.replace(hash)
      end
    end
  end
end
