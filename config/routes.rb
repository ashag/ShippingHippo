ShippingHippo::Application.routes.draw do

  post 'rates'        => 'rate_requests#carrier_request'
  
end
