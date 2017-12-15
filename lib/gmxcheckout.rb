require 'hashie'
require 'faraday'

require 'gmxcheckout/version'

module GmxCheckout
  autoload :API,            'gmxcheckout/api'
  autoload :Base,           'gmxcheckout/base'
  autoload :JsonMiddleware, 'gmxcheckout/json_middleware'
  autoload :Model,          'gmxcheckout/model'
  autoload :Response,       'gmxcheckout/response'
  autoload :Subscriptions,  'gmxcheckout/subscriptions'

  module Models
    autoload :Transaction,  'gmxcheckout/models/transaction'
    autoload :Notification, 'gmxcheckout/models/notification'
  end

  class << self
    attr_accessor :api_key
  end

  def self.configure(&block)
    instance_eval(&block)
  end

  def self.statuses
    @statuses ||= {
      initiated: 0,
      captured: 1,
      cancelled: 3,
      suspended: 4,
      approved: 5,
      rejected: 6,
      incommunicable: 7
    }
  end
end
