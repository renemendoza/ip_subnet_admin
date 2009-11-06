ActionController::Routing::Routes.draw do |map|

  map.root :controller => "devices"

  map.resources :networks do |network|
    network.resources :devices
    network.resources :dhcp_options
  end

  map.resources :vendors
  #
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
