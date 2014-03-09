class ShippingClient
  include ActiveMerchant::Shipping
  attr_reader :origin, :destination, :package, :ups, :fedex

  def initialize(hash, options={})
    @origin = Location.new(hash[:origin])
    @destination = Location.new(hash[:destination])
    @package = parse_package(hash[:package])

    save_request(hash)

  end

  def save_request(params_hash)
    # check if I need to convert params_hash to string
    RateRequest.create(request_data: params_hash.to_s)
  end

  def save_response(get_fedex, get_ups)
    response_hash = get_fedex, get_ups
    RateResponse.create(response_data: response_hash.to_s)
  end

  def parse_package(package_hash)
    dimensions = package_hash[:height].to_i, package_hash[:depth].to_i, package_hash[:length].to_i
    Package.new(package_hash[:weight].to_i, dimensions, :units => :imperial)
  end

  def rates
    @ups = ups_client.find_rates(@origin, @destination, @package)
    {:service => 'ups', :price => 10}
    [[ups]]

    @fedex = fedex_client.find_rates(@origin, @destination, @package)
  end

  def ups_client
    UPS.new(:login => ENV["UPS_USER_ID"],
      :password => ENV["UPS_PASSWORD"], 
      :key => ENV["UPS_KEY"])

  def fedex_client
   FedEx.new(:login => ENV["FEDEX_LOGIN"], 
      :password => ENV["FEDEX_PASSWORD"], 
      :key => ENV["FEDEX_KEY"], 
      :account => ENV["FEDEX_ACCOUNT"], 
      :test => true)
  end
end