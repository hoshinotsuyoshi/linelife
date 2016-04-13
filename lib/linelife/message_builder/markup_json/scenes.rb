module Linelife
  class MessageBuilder
    class MarkupJson < ::Hash
      # https://developers.line.me/businessconnect/api-reference#sending_rich_content_message
      class Scenes < ::Hash
        class Error < ::StandardError; end
        def self.create(strategy)
          !strategy[:actions] && raise(Error, 'actions Array is missing.')
          strategy[:actions].empty? && raise(Error, 'actions Array is blank.')

          # [description].
          # [value].
          hash = {
            # Rich messages can have only one scene named "scene1".
            scene1: {
              # The scene has two sub-models draws and listeners.
              draws: [draw(strategy)],
              listeners: listeners(strategy)
            }
          }
          new.replace(hash)
        end

        def self.draw(strategy)
          {
            # The image ID.
            # Use the image ID "image1".
            image: 'image1',
            # x-coordinate value.
            # Fixed 0.
            x: 0,
            # y-coordinate value.
            # Fixed 0.
            y: 0,
            # Width of the image.
            # Integer value. Any one of 1040, 700, 460, 300, 240.
            #   This value must be same as the image width.
            w: strategy[:width] || 1040,
            # Height of the image.
            # Integer value. Max value is 2080px.
            h: strategy[:height] || 1040
          }
        end

        def self.listeners(strategy)
          array = []
          size = strategy[:actions].size
          strategy[:actions].each.with_index do |h, index|
            array << ({
              # Event type.
              # Fixed "touch".
              type: 'touch',
              # Rectangular area where tap event is received.
              # Array of the rectangle information. [x, y, width, height].
              params: h[:listener_params] || horizontal(strategy, size, index),
              # Action ID to be executed when the tap event occurs.
              # Action ID string. For example, "openHomepage".
              action: h[:name].to_s
            })
          end
          array
        end

        def self.horizontal(strategy, size, index)
          [
            0,
            (draw(strategy)[:h] / size) * index,
            draw(strategy)[:w],
            draw(strategy)[:h] / size
          ]
        end
      end
    end
  end
end
