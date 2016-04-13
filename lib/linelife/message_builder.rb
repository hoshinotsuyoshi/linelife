require 'json'
require 'linelife/message_builder/content_metadata'

module Linelife
  #
  # Build message hash to send
  #
  class MessageBuilder
    TRIAL_API_TO_CHANNEL = 1_383_378_250 # Fixed value
    TRIAL_API_EVENT_TYPE = '138311608800106203'.freeze # Fixed value

    def build(to:, text: nil)
      base_message(to: to).merge(
        content: {
          contentType: 1,
          toType: 1,
          text: text.to_s
        }
      )
    end

    def build_rich(to:, strategy:)
      base_message(to: to).merge(
        content: {
          contentType: 12,
          toType: 1,
          contentMetadata: ContentMetadata.create(strategy)
        }
      )
    end

    private

    def base_message(to:)
      {
        to: [to].flatten,
        toChannel: TRIAL_API_TO_CHANNEL,
        eventType: TRIAL_API_EVENT_TYPE
      }
    end
  end
end
