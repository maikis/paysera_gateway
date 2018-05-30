require_dependency "paysera_gateway/application_controller"

module PayseraGateway
  class PaymentsController < ApplicationController
    def make_payment
      payment_data = params[:payment_data].permit!.to_h
      req = Request.new(payment_data)
      redirect_to req.build.to_s if req.valid?
    end
  end
end
