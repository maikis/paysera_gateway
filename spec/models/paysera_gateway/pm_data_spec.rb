require 'rails_helper'

module PayseraGateway
  RSpec.describe PMData, type: :model do
    def stub_payment_methods_empty
      body = File.read('spec/stubs/payment_methods_no_amount.xml')
      stub_request(:get, 'https://www.paysera.com/new/api/paymentMethods/12345'\
                           '/currency:/amount:/language:lt')
        .to_return(status: 200, body: body, headers: {})
    end

    def stub_payment_methods_full
      body = File.read('spec/stubs/payment_methods_full.xml')
      stub_request(:get, 'https://www.paysera.com/new/api/paymentMethods/12345'\
                           '/currency:eur/amount:1000/language:lt')
        .to_return(status: 200, body: body, headers: {})
    end

    describe 'required params' do
      it 'raises error if projectid is missing' do
        expect{ PMData.fetch({}) }
          .to raise_error(ParamError, 'Required param "projectid" missing.')
      end
    end

    it 'returns a hash with basic payment method data from paysera service' do
      stub_payment_methods_empty
      expect(PMData.fetch({projectid: 12345, language: 'lt'}))
        .to eq('payment_types_document' => { 'project_id' => '12345',
                                             'currency'   => 'EUR',
                                             'amount'     => '',
                                             'language'   => 'lt'})
    end

    it 'returns full hash with payments if amount is given' do
      stub_payment_methods_full
      expect(PMData.fetch({ projectid: 12345,
                            currency: 'eur',
                            amount: 1000,
                            language: 'lt' })['payment_types_document'])
        .to include('country')
    end
  end
end
