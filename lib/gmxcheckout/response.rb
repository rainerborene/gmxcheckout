module GmxCheckout
  class Response
    attr_reader :message, :errors, :body

    def initialize(body, klass = nil)
      @errors = body.dig('errors', '@items') || []
      @message = body['msgRetorno'] || body['msgRetornoAdquirente']
      @reason = body['status']
      @body = klass.respond_to?(:new) ? klass.new(body) : body
    end

    def reason_phrase
      @reason
    end

    def success?
      errors.empty? && reason_phrase != 'fail'
    end
  end
end
