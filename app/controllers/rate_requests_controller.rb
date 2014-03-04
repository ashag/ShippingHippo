class RateRequestsController < ApplicationController
  before_action :test_params

  def carrier_request(request_params)
    # Hippo must pass json with defined data structure
    # package params is an array, not a hash

    origin, destination, package = RateRequest.parse_hash(request_params)
    fedex = RateRequest.fedex
    @shipment = fedex.find_rates(origin, destination, package)
    

    respond_to do |format|
      if @shipment 
        RateRequest.create(request_data: @shipment) 
        format.html 
        format.json { render json: @shipment, status: :ok}
      else
        format.html 
        format.json { render json: {msg: 'Error'} }
      end
    end
  end

  private

  def test_params
    if params[:origin][:country].nil?
      render json: { msg: "Country is missing."}, status: :bad_request and return
    end  
  end

  def request_params
    # create special error messages for requests with missing params?
    params.require(:origin).require(:country, :state, :city, :zip)
    params.require(:destination).require(:country, :state, :city, :zip)
    params.require(:package).require(:weight, :height, :depth, :length)
  end

end
