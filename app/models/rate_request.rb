class RateRequest < ActiveRecord::Base
  include ActiveMerchant::Shipping
  #  json hash can be passed to Hippo w/o parsing data first ex. @pets.as_json(only: [:id, :name, :age, :human])


  def self.parse_hash(hash)
    @origin_parse = hash["origin"]
    @destination_parse = hash["destination"]
    @package_parse = hash["package"]

    set_request_params(@origin_parse, @destination_parse, @@package_parse)    
  end

  def set_request_params(origin_parse, destination_parse, package_parse)
    @origin = set_origin(origin_parse)
    @destination = set_destination(destination_parse)
    @package = set_package(package_parse)

    return @origin, @destination, @package
  end

  def set_origin(origin_hash)
    Location.new(origin_hash)
  end

  def set_destination(destination_hash)
    Location.new(destination_hash)
  end

  def set_package(package_array)
    Package.new(package_array)
  end

  def get_rates
    self.rates.sort_by(&:price).collect { |rate| 
      rate.service_name, 
      rate.price, 
      rate.delivery_date 
    }
  end

  def self.fedex
    FedEx.new(:login => ENV["FEDEX_LOGIN"], 
              :password => ENV["FEDEX_PASSWORD"], 
              :key => ENV["FEDEX_KEY"], 
              :account => ENV["FEDEX_ACCOUNT"], 
              :test => true)

  end

  def self.usps
    USPS.new(
      )

  end

  def self.drone

  end

  def self.bike_messenger

  end
end
