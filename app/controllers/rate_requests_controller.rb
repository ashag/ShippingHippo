class RateRequestsController < ApplicationController
  # before_action :test_params

  def carrier_request
    save_request(params)
    origin, destination, package = RateRequest.set_request_params(params)
    fedex_client = RateRequest.fedex
    @shipment = fedex_client.find_rates(origin, destination, package)    

    respond_to do |format|
      if @shipment
        save_response(@shipment) 
        format.html 
        format.json { render json: @shipment, status: :ok}
      else
        format.html 
        format.json { render json: {msg: 'Error'} }
      end
    end
  end

  def save_request(params)
    request_string = params.to_s
    RateRequest.create(request_data: request_string)
  end

  def save_response(response_hash)
    response_string = response_hash.to_s
    RateResponse.create(response_data: response_string)
  end

  private

  # def test_params
  #   if params[:origin][:country].nil?
  #     render json: { msg: "Country is missing."}, status: :bad_request and return
  #   end  
  # end

  def request_params
    params.require(:origin).permit(:country, :state, :city, :zip)
    params.require(:destination).permit(:country, :state, :city, :zip)
    params.require(:package).permit(:weight, :height, :depth, :length)
  end

end
