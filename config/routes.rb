PayseraGateway::Engine.routes.draw do
  post '/payments', to: 'payments#make_payment'
end
