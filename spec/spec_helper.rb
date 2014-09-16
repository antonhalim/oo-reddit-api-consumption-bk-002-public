require_relative '../config/environment'
require 'yaml'
Bundler.require(:test)

RSpec.configure do |config|
  config.order = 'default'
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.debug_logger = File.open('spec/fixtures/debug.log', 'w')
end

def use_vcr(cassette_name, &expectation)
  VCR.use_cassette(cassette_name, record: :new_episodes, decode_compressed_response: true) do
    yield
  end
end
