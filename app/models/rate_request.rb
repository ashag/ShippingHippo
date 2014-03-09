class RateRequest < ActiveRecord::Base
  include ActiveMerchant::Shipping

  # def self.set_request_params(hash)
  #   origin = set_origin(hash[:origin])
  #   destination = set_destination(hash[:destination])
  #   package = set_package(hash[:package])

  #   return origin, destination, package
  # end

  # def self.set_origin(origin_hash)
  #   Location.new(origin_hash)
  # end

  # def self.set_destination(destination_hash)
  #   Location.new(destination_hash)
  # end

  # def self.set_package(package_hash)
  #   dimensions = package_hash[:height].to_i, package_hash[:depth].to_i, package_hash[:length].to_i
  #   Package.new(package_hash[:weight].to_i, dimensions, :units => :imperial)
  # end

  # def self.fedex
  #   FedEx.new(:login => ENV["FEDEX_LOGIN"], 
  #             :password => ENV["FEDEX_PASSWORD"], 
  #             :key => ENV["FEDEX_KEY"], 
  #             :account => ENV["FEDEX_ACCOUNT"], 
  #             :test => true)

  # end

  # def self.ups
  #   UPS.new(:login => ENV["UPS_USER_ID"],
  #           :password => ENV["UPS_PASSWORD"], 
  #           :key => ENV["UPS_KEY"])
  # end

end
