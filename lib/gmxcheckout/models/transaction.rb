module GmxCheckout
  module Models
    class Transaction < Model
      with = -> (hash) { hash&.fetch('value', nil) }

      property :credit_card_mask, from: 'venda.cartaoCredito.numeroMask'
      property :subscription_code, from: 'recorrencia.idRecorrencia', with: with
      property :subscription_status, from: 'recorrencia.status', with: with
    end
  end
end
