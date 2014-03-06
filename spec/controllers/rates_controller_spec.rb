require 'spec_helper'

describe RateRequestsController do

  context 'carrier request method' do 
    let(:hash) { {:origin => { zip: '98102'}, :destination => { :city => 'Seattle'}, :package => {:weight => 70, :height => 15, :depth => 10, :length => 4 } } }

    it 'will save the request' do 
      post :carrier_request, request_data: :hash
      expect(:carrier_request).to change(RateRequest.count).by(1)
    end

    it ''
  end
end
