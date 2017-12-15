module GmxCheckout
  class Subscriptions < Base
    def create(hash)
      response = api.post '/txn/post', create_params(hash)
      process_transaction response
    end

    def update(hash)
      response = api.post '/txn/post', update_params(hash)
      process_transaction response
    end

    def cancel(code)
      response = api.post '/txn/cancelaRecorrencia',
                          'hashEmpresa' => api.api_key,
                          'recorrencia.idRecorrencia' => code

      process_body response
    end

    private

    def update_params(hash)
      prepare! \
        'venda.recorrencia.idRecorrencia' => hash[:id],
        'venda.consumidor.nome'           => hash.dig(:customer, :name),
        'venda.consumidor.cpf'            => hash.dig(:customer, :cpf),
        'venda.valor'                     => hash[:amount],
        'venda.capturaAuto'               => false,

        'cartaoCredito.numero'       => hash.dig(:credit_card, :number),
        'cartaoCredito.codSeguranca' => hash.dig(:credit_card, :cvc),
        'cartaoCredito.mesValidade'  => hash.dig(:credit_card, :exp_month),
        'cartaoCredito.anoValidade'  => hash.dig(:credit_card, :exp_year),
        'cartaoCredito.bandeira'     => hash.dig(:credit_card, :brand)
    end

    def create_params(hash)
      amounts = hash[:amounts].join('|') if hash[:amounts].is_a? Array

      prepare! \
        'recorrencia.modalidaderecorrencia' => 1,
        'recorrencia.idrecorrenciaEmpresa'  => hash[:id],
        'recorrencia.urlCampainha'          => hash[:notification_url],
        'recorrencia.ipOrigem'              => hash[:remote_ip],
        'recorrencia.browser'               => hash[:browser],
        'recorrencia.produto'               => hash[:description],
        'recorrencia.descricaoFatura'       => hash[:invoice_name],
        'recorrencia.parcelas'              => hash[:installments],
        'recorrencia.valor'                 => hash[:amount],
        'recorrencia.valorParcelas'         => amounts,

        'recorrencia.consumidor.nome'      => hash.dig(:customer, :name),
        'recorrencia.consumidor.email'     => hash.dig(:customer, :email),
        'recorrencia.consumidor.telefone1' => hash.dig(:customer, :phone),
        'recorrencia.consumidor.cpf'       => hash.dig(:customer, :cpf),

        'recorrencia.consumidor.endereco' => hash.dig(:address, :street),
        'recorrencia.consumidor.numero'   => hash.dig(:address, :number),
        'recorrencia.consumidor.bairro'   => hash.dig(:address, :district),
        'recorrencia.consumidor.cidade'   => hash.dig(:address, :city),
        'recorrencia.consumidor.cep'      => hash.dig(:address, :postal_code),
        'recorrencia.consumidor.pais'     => hash.dig(:address, :country),

        'cartaoCredito.portador'     => hash.dig(:credit_card, :holder_name),
        'cartaoCredito.numero'       => hash.dig(:credit_card, :number),
        'cartaoCredito.codSeguranca' => hash.dig(:credit_card, :cvc),
        'cartaoCredito.mesValidade'  => hash.dig(:credit_card, :exp_month),
        'cartaoCredito.anoValidade'  => hash.dig(:credit_card, :exp_year),
        'cartaoCredito.bandeira'     => hash.dig(:credit_card, :brand)
    end
  end
end
