module GmxCheckout
  module Models
    class Notification < Model
      # property :subscription_code, from: 'recorrencia.idRecorrenciaEmpresa'
      # property :transaction_amount, from: 'venda.valor'
      # property :transaction_owner_id, from: 'venda.idVendaEmpresa'

      property :subscription_code, from: 'recorrencia.idRecorrencia'

      property :subscription_status, from: 'recorrencia.status',
                                     with: -> (value) { value.to_i }

      property :subscription_created_at, from: 'recorrencia.dataRegistro',
                                         with: -> (value) { value.to_date }

      property :subscription_latest_payment,
               from: 'recorrencia.valorUltimoProcessamento'

      property :transaction_date, from: 'venda.dataRegistro',
                                  with: -> (value) { value.to_date }

      property :transaction_amount, from: 'venda.valor',
                                    with: -> (value) { value.to_i }

      property :transaction_id, from: 'venda.idVenda',
                                with: -> (value) { value.to_i }

      property :transaction_status, from: 'venda.status',
                                    with: -> (value) { value.to_i }

      property :transaction_gateway_id, from: 'venda.tid'
      property :transaction_gateway_uuid, from: 'venda.nsu'
      property :transaction_rejected_status, from: 'venda.lr'
      property :transaction_rejected_message, from: 'venda.lrDescricao'
      property :transaction_rejected_suggestion, from: 'venda.lrOrientacao'

      property :credit_card_mask, from: 'venda.cartaoCredito.numeroMask'
      property :credit_card_brand, from: 'venda.formaPagamento'

      property :transaction_auth_code, from: 'venda.arp'
      property :transaction_eci, from: 'venda.eci'
      property :transaction_message, from: 'venda.msgErro'
      property :transaction_gateway, from: 'venda.adquirente'

      def success?
        transaction_message.blank?
      end
    end
  end
end
