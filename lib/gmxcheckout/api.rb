module GmxCheckout
  class API
    extend Forwardable

    def_delegators :@connection, :get, :post, :put, :patch

    def self.build_notification(params)
      Models::Notification.new params
    end

    def initialize(api_key = nil)
      @api_key = api_key
      @connection = Faraday.new url: 'https://www.gmxcheckout.com.br' do |conn|
        conn.use JsonMiddleware
        conn.request :url_encoded
        conn.adapter :net_http
      end
    end

    def subscriptions
      @subscriptions ||= Subscriptions.new(self)
    end

    def api_key
      @api_key || GmxCheckout.api_key
    end

    alias key api_key
  end
end
