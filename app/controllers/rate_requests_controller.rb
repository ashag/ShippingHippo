class RateRequestsController < ApplicationController

  def homepage

  end

  def carrier_request
    save_request
    origin, destination, package = RateRequest.set_request_params(params)
    json_for_hippo = response_for_hippo(origin, destination, package)

    respond_to do |format|
      if json_for_hippo
        format.json { render json: json_for_hippo, status: :ok}
      else
        format.json { render json: {msg: 'Error'} }
      end
    end
  end


  def response_for_hippo(origin, destination, package)
    get_fedex = fedex_client_response(origin, destination, package)
    get_ups = ups_client_response(origin, destination, package)
    save_response(get_fedex, get_ups)
    parse_to_hash(get_fedex, get_ups)
  end

  def parse_to_hash(fedex, ups)
    f = fedex.rates.sort_by(&:price).collect {|rate| { service: rate.service_name, price: rate.price, delivery_range: rate.delivery_date} }
    u = ups.rates.sort_by(&:price).collect {|rate| { service: rate.service_name, price: rate.price, delivery_range: rate.delivery_date} }
    return [f, u]
  end

  def fedex_client_response(origin, destination, package)
    RateRequest.fedex.find_rates(origin, destination, package)    
  end

  def ups_client_response(origin, destination, package)
    RateRequest.ups.find_rates(origin, destination, package)    
  end

  def save_request
    RateRequest.create(request_data: params.to_s)
  end

  def save_response(get_fedex, get_ups)
    response_hash = get_fedex, get_ups
    RateResponse.create(response_data: response_hash.to_s)
  end

  private
  def request_params
    params.require(:origin).permit(:country, :state, :city, :zip)
    params.require(:destination).permit(:country, :state, :city, :zip)
    params.require(:package).permit(:weight, :height, :depth, :length)
  end
end
