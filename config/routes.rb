ShippingHippo::Application.routes.draw do

  get 'rates'         => 'rate_requests#carrier_request'
  post 'rates'        => 'rate_requests#carrier_request'
  
end
