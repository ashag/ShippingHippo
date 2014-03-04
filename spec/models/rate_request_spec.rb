require 'spec_helper'

describe RateRequest do 

  context 'set_request_params method' do
    let(:hash) { {:origin => { zip: '98102'}, :destination => { :city => 'Seattle'}, :package => {:weight => 70, :height => 15, :depth => 10, :length => 4 } } }

    it 'returns Location for origin' do  
      origin, destination, package = RateRequest.set_request_params(hash)
      expect(origin).to be_a ActiveMerchant::Shipping::Location 
    end


    it 'returns Location object for destination' do 
      origin, destination, package = RateRequest.set_request_params(hash)
      expect(destination).to be_a ActiveMerchant::Shipping::Location
    end

    it 'returns Package object for package' do  
      origin, destination, package = RateRequest.set_request_params(hash)
      expect(package).to be_a ActiveMerchant::Shipping::Package 
    end

    it 'origin is assigned origin key data' do
      origin, destination, package = RateRequest.set_request_params(hash)
      expect(origin.zip).to eq '98102'
    end

    it 'destination is assigned destination key data' do
      origin, destination, package = RateRequest.set_request_params(hash)
      expect(destination.city).to eq 'Seattle'
    end

    it 'origin is assigned origin key data' do
      origin, destination, package = RateRequest.set_request_params(hash)
      expect(orig.zip).to eq '98102'
    end


  end

  describe 'set origin' do 

  end

end