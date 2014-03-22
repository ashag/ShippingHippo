class RateRequestsController < ApplicationController

  def carrier_request
    rates = ShippingClient.new(params)
    respond_to do |format|
      if rates
        save_response(rates)
        format.json { render json: rates, status: :ok}
      else
        format.json { render json: {msg: 'Error'} }
      end
    end
  end

  def save_response(rates)
    RateResponse.create(response_data: rates.to_s)
  end

  private
  def request_params
    params.require(:origin).permit(:country, :state, :city, :zip)
    params.require(:destination).permit(:country, :state, :city, :zip)
    params.require(:package).permit(:weight, :height, :depth, :length)
  end
end
