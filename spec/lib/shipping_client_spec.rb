require 'spec_helper' 

describe ShippingClient do 
  let(:hash) { {:origin => { zip: '98102'}, :destination => { :city => 'Seattle'}, :package => {:weight => 70, :height => 15, :depth => 10, :length => 4 } } }
  let(:client) { ShippingClient.new(hash) }

  it "returns ups rates" do
    rates = ShippingClient.new(hash, carriers: [:ups, :fedex]).rates
    expect(rates.first.first[:service]).to eq "ups"
  end

  it "returns ups rates" do
    rates = ShippingClient.new(hash, carriers: [:ups, :fedex]).rates
    expect(rates.first.first[:price]).to be_an_instance_of Integer
  end

  it 'returns Location for origin' do  
      expect(client.origin).to be_a ActiveMerchant::Shipping::Location 
    end


    it 'returns Location object for destination' do 
      expect(client.destination).to be_a ActiveMerchant::Shipping::Location
    end

    it 'returns Package object for package' do  
      expect(client.package).to be_a ActiveMerchant::Shipping::Package 
    end

    it 'origin is assigned origin key data' do
      expect(client.origin.zip).to eq '98102'
    end

    it 'destination is assigned destination key data' do
      expect(client.destination.city).to eq 'Seattle'
    end

    # test that values are assigned to correct variable
    it 'package is assigned package key data' do
      expect(client.package.weight).to eq 70
    end


end