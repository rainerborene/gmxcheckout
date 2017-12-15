require 'spec_helper'

describe GmxCheckout::API do
  it 'creates a new subscription' do
    response = VCR.use_cassette 'charge' do
      gmx = GmxCheckout::API.new
      gmx.subscriptions.create(
        amount: 100, # 1 real
        description: 'teste recorrencia',
        customer: {
          name: 'Teste consumidor nome',
          email: 'teste@email.com',
          phone: '(11) 1111-11111',
          cpf: '559.343.990-71'
        },
        credit_card: {
          brand: :visa,
          holder_name: 'TESTE TESTE',
          number: '4012001037141112',
          exp_month: '05',
          exp_year: '2018',
          cvc: '123'
        }
      )
    end

    assert_equal response.body.credit_card_mask, '************1112'
    assert_equal response.body.subscription_code, 145_054
    assert_equal response.body.subscription_status, 5
  end

  it 'updates credit card information' do
    response = VCR.use_cassette 'update' do
      gmx = GmxCheckout::API.new
      gmx.subscriptions.update(
        id: 145_068,
        amount: 100,
        customer: {
          name: 'Jeanny Lifewalker',
          cpf: '77266962226'
        },
        credit_card: {
          brand: :mastercard,
          number: '4532286020241463',
          exp_month: '02',
          exp_year: '2030',
          cvc: '123'
        }
      )
    end

    assert response.success?
  end

  it 'cancelling subscription' do
    response = VCR.use_cassette 'cancel' do
      gmx = GmxCheckout::API.new
      gmx.subscriptions.cancel(145_068)
    end

    assert_equal response.status, 'success'
  end
end
