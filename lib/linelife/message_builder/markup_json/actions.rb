module Linelife
  class MessageBuilder
    class MarkupJson < ::Hash
      # https://developers.line.me/businessconnect/api-reference#sending_rich_content_message
      class Actions < ::Hash
        class Error < ::StandardError; end
        def self.create(strategy)
          hash = {}
          !strategy[:actions] && raise(Error, 'actions Array is missing.')
          strategy[:actions].empty? && raise(Error, 'actions Array is blank.')
          strategy[:actions].each do |h|
            hash.merge!(
              h[:name].to_sym =>
              { type: 'web', text: h[:text].to_s, params: { linkUri: h[:link_uri] } }
            )
          end
          new.replace(hash)
        end
      end
    end
  end
end
