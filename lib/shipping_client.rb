class ShippingClient
  include ActiveMerchant::Shipping
  attr_reader :origin, :destination, :package

  def initialize(hash)
    @origin = Location.new(hash[:origin])
    @destination = Location.new(hash[:destination])
    @package = parse_package(hash[:package])
    save_request(hash)

    carrier_rates
  end

  def save_request(params_hash)
    RateRequest.create(request_data: params_hash.to_s)
  end

  def carrier_rates
    ups = ups_client.find_rates(@origin, @destination, @package)
    fedex = fedex_client.find_rates(@origin, @destination, @package)

    rates(ups, fedex)
  end

  def parse_package(package_hash)
    dimensions = package_hash[:height].to_i, package_hash[:depth].to_i, package_hash[:length].to_i
    Package.new(package_hash[:weight].to_i, dimensions, :units => :imperial)
  end

  def rates(ups, fedex)
    fedex.rates.sort_by(&:price).collect {|rate| { service: rate.service_name, price: rate.price} }
    ups.rates.sort_by(&:price).collect {|rate| { service: rate.service_name, price: rate.price} }
  end

  def ups_client
    UPS.new(:login => ENV["UPS_USER_ID"],
      :password => ENV["UPS_PASSWORD"], 
      :key => ENV["UPS_KEY"])
  end

  def fedex_client
   FedEx.new(:login => ENV["FEDEX_LOGIN"], 
      :password => ENV["FEDEX_PASSWORD"], 
      :key => ENV["FEDEX_KEY"], 
      :account => ENV["FEDEX_ACCOUNT"], 
      :test => true)
  end
end