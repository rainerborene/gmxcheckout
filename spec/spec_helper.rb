$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'gmxcheckout'
require 'minitest/autorun'
require 'minitest/spec'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures'
  config.hook_into :faraday
end
