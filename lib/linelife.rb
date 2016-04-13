require 'linelife/message'
require 'linelife/message_builder'
require 'linelife/message_deliverer'
require 'linelife/message_extractor'

#
# line bot api
#
module Linelife
  def send_message(hash)
    message = Message::Outbound.new(hash)
    MessageDeliverer.new.send(message)
  end

  module_function :send_message

  def extract_messages(request)
    MessageExtractor.new.extract(request)
  end

  module_function :extract_messages

  def build_message(to:, text: nil)
    MessageBuilder.new.build(to: to, text: text)
  end

  module_function :build_message

  def build_rich_message(to:, strategy:)
    MessageBuilder.new.build_rich(to: to, strategy: strategy)
  end

  module_function :build_rich_message
end
