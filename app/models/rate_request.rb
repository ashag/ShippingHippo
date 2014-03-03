class RateRequest < ActiveRecord::Base
  include ActiveMerchant::Shipping
  #  json hash can be passed to Hippo w/o parsing data first ex. @pets.as_json(only: [:id, :name, :age, :human])


  def self.parse_hash(hash)
    @origin_parse = hash["origin"]
    @destination_parse = hash["destination"]
    @package_parse = hash["package"]

    set_request_params(@origin_parse, @destination_parse, @package_parse)    
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
    # weight is in ounces
    dimensions = package_array[:height].to_f, package_array[:depth].to_f, package_array[:length].to_f
    Package.new(package_array[:ounces], dimensions, :units => :imperial)
  end


  # active shipping method returns an array. Pointless to parse for Hippo??
  # def get_rates
  #   carrier_rates = {}

  #   self.rates.sort_by(&:price).collect { |rate| 
  #     carrier_rates[:service_name] = rate.service_name, 
  #     carrier_rates[:price] = rate.price, 
  #     carrier_rates[:devliery_date] = rate.delivery_date 
  #   }

  #   return carrier_rates
  # end

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

end
