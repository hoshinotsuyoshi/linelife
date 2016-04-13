module Linelife
  class MessageBuilder
    class MarkupJson < ::Hash
      # https://developers.line.me/businessconnect/api-reference#sending_rich_content_message
      class Images < ::Hash
        class Error < ::StandardError; end
        def self.create(strategy)
          # [description].
          # [value].
          hash = {
            image1: {
              # The x-coordinate value of the image.
              # Fixed 0.
              x: 0,
              # The y-coordinate value of the image.
              # Fixed 0.
              y: 0,
              # The width of the image.
              # Integer fixed value: 1040.
              w: 1040,
              # The height of the image.
              # Integer value. Max value is 2080px.
              h: strategy[:image_image1_h] || 1040
            }
          }
          new.replace(hash)
        end
      end
    end
  end
end
