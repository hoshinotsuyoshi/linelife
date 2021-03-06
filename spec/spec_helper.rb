$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'linelife'

require 'webmock/rspec'
WebMock.enable!

# load spec/support/**/*.rb
require 'pathname'
app_root = Pathname(File.expand_path('../..', __FILE__))
Dir[app_root.join('spec/support/**/*.rb')].each do |f|
  require f
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
