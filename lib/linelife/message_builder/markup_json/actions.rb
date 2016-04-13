module Linelife
  class MessageBuilder
    class MarkupJson < ::Hash
      # https://developers.line.me/businessconnect/api-reference#sending_rich_content_message
      class Actions < ::Hash
        class Error < ::StandardError; end
        def self.create(strategy)
          validate!(strategy)
          hash = {}
          strategy[:actions].each do |h|
            hash.merge!(build_action(h))
          end
          new.replace(hash)
        end

        def self.validate!(strategy)
          !strategy[:actions] && raise(Error, 'actions Array is missing.')
          strategy[:actions].empty? && raise(Error, 'actions Array is blank.')
        end

        private_class_method :validate!

        def self.build_action(h)
          {
            h[:name].to_sym => {
              type: 'web',
              text: h[:text].to_s,
              params: { linkUri: h[:link_uri] }
            }
          }
        end

        private_class_method :build_action
      end
    end
  end
end
