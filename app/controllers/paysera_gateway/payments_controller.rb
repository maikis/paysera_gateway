require_dependency "paysera_gateway/application_controller"

module PayseraGateway
  class PaymentsController < ApplicationController
    def make_payment
      payment_data = params[:payment_data].permit!.to_h
      req = Request.new(payment_data)
      redirect_to req.build.to_s if req.valid?
    end

    def methods
      pm = PMData.fetch(pm_params)
      render json: pm
    end

    private

    def pm_params
      {
        projectid: params[:projectid],
        currency:  params[:currency],
        amount:    params[:amount],
        language:  params[:language]
      }
    end
  end
end
