module GmxCheckout
  class Base
    attr_reader :api

    def initialize(api)
      @api = api
    end

    def process_transaction(response)
      Response.new response.body, Models::Transaction
    end

    def process_body(response)
      Hashie::Mash.new response.body
    end

    def prepare!(params)
      params.tap do |hash|
        hash['empresa.hashEmpresa'] = api.key
        hash['restApi'] = true
        hash.compact!
      end
    end
  end
end
