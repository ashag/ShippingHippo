class RateRequestsController < ApplicationController

  def carrier_request(request_params)
    # Hippo must pass json with defined data structure
    # package params is an array, not a hash

    hippo_parse = RateRequest.parse_hash(request_params)
    fedex = RateRequest.fedex
    @shipment = fedex.find_rates(hippo_parse)
    

    respond_to do |format|
      if @shipment 
        RateRequest.create(request_data: @shipment) 
        format.html { } 
        format.json { render json: @shipment, status: :ok}
      else
        format.html { message: }
        format.json { message: 'Error'}
      end
    end
  end

  private
  def request_params
    # create special error messages for requests with missing params?
    params.require(:origin).require(:country, :state, :city, :zip)
    params.require(:destination).require(:country, :state, :city, :zip)
    params.require(:package).require(:ounces, :height, :depth, :length)
  end

end
