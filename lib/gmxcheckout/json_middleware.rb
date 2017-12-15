module GmxCheckout
  class JsonMiddleware < Faraday::Response::Middleware
    dependency 'multi_json'

    def parse(body)
      MultiJson.load clean!(body)
    end

    private

    def clean!(body)
      body.delete!('\\')
          .gsub!(/^"/, '')
          .gsub!(/[";\n]+$/, '')
    end
  end
end
