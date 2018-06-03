require 'rails_helper'

RSpec.describe 'Payments', type: :request do
  describe 'GET /paysera_gateway/payment_methods' do
    context '#methods' do
      let(:params) do
        { projectid: 12_345, currency: 'eur', amount: 1000, language: 'lt' }
      end

      def stub_payment_methods_full
        body = File.read('spec/stubs/payment_methods_full.xml')
        stub_request(:get, 'https://www.paysera.com/new/api/paymentMethods/'\
                           '12345/currency:eur/amount:1000/language:lt')
          .to_return(status: 200, body: body, headers: {})
      end

      it 'returns payment methods from paysera' do
        stub_payment_methods_full
        get paysera_gateway.payment_methods_path, params: params
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['payment_types_document']).to include('country')
      end
    end
  end
end
