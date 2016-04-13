module Linelife
  class MessageBuilder
    class MarkupJson < ::Hash
      # https://developers.line.me/businessconnect/api-reference#sending_rich_content_message
      class Canvas < ::Hash
        class Error < ::StandardError; end
        def self.create(strategy)
          # [description].
          # [value].
          hash = {
            # Width of the canvas area.
            # Integer fixed value: 1040.
            width: 1040,
            # Height of the canvas area.
            # Integer value. Max value is 2080px.
            height: strategy[:canvas_height] || 1040,
            # Name of initial scene.
            # Fixed string "scene1".
            initialScene: 'scene1'
          }
          new.replace(hash)
        end
      end
    end
  end
end
