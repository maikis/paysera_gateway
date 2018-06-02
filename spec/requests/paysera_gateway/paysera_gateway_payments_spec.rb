require 'rails_helper'

RSpec.describe 'Payments', type: :request do
  describe 'GET /paysera_gateway/payment_methods' do
    it 'returns payment methods from paysera' do
      get paysera_gateway.payment_methods_path
      expect(response.body).to eq({}.to_json)
    end
  end
end
