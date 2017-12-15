module GmxCheckout
  class Model < Hashie::Dash
    include Hashie::Extensions::Dash::PropertyTranslation
    include Hashie::Extensions::IgnoreUndeclared
  end
end
