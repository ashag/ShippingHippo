class RateRequestsController < ApplicationController
  # before_action :test_params

  def carrier_request
    # Hippo must pass json with defined data structure
    # package params is an array, not a hash

    save_request(params)
    origin, destination, package = RateRequest.set_request_params(params[])
    fedex_client = RateRequest.fedex
    @shipment = fedex_client.find_rates(origin, destination, package)
    

    respond_to do |format|
      if @shipment 
        RateResponse.create(request_data: @shipment) 
        format.html 
        format.json { render json: @shipment, status: :ok}
      else
        format.html 
        format.json { render json: {msg: 'Error'} }
      end
    end
  end

  def save_request
    RateRequest.create(request_params)
  end

  private

  # def test_params
  #   if params[:origin][:country].nil?
  #     render json: { msg: "Country is missing."}, status: :bad_request and return
  #   end  
  # end

  def request_params
    # create special error messages for requests with missing params?
    o = params.require(:origin).permit(:country, :state, :city, :zip)
    d = params.require(:destination).permit(:country, :state, :city, :zip)
    p = params.require(:package).permit(:weight, :height, :depth, :length)

    return [o, d, p]
  end

end
