PayseraGateway::Engine.routes.draw do
  post '/payments', to: 'payments#make_payment'
  get  '/payment_methods', to: 'payments#methods'
end
