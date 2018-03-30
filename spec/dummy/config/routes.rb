Rails.application.routes.draw do
  mount PayseraGateway::Engine => "/paysera_gateway"
end
