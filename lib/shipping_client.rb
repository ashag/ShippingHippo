class ShippingClient
  include ActiveMerchant::Shipping
  attr_reader :origin, :destination, :package

  def initialize(hash, options={})
    @origin = Location.new(hash[:origin])
    @destination = Location.new(hash[:destination])
    @package = parse_package(hash[:package])

  end

  def parse_package(package_hash)
    dimensions = package_hash[:height].to_i, package_hash[:depth].to_i, package_hash[:length].to_i
    Package.new(package_hash[:weight].to_i, dimensions, :units => :imperial)
  end

  def rates
    ups = {:service => 'ups'}
    [[ups]]
  end


end