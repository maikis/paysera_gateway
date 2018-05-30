require 'rails_helper'

RSpec.describe 'routes for PayseraGateway', :type => :routing do
  routes { PayseraGateway::Engine.routes }
  it 'routes /paysera_gateway/payments to the payments controller' do
    expect(post('/payments'))
      .to route_to(
        controller: 'paysera_gateway/payments',
        action: 'make_payment'
      )
  end
end