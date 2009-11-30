map.namespace :admin do |admin|
    admin.resources :service_contracts
    admin.resources :products, :member => {:clone => :get}, :has_many => [:product_properties, :images] do |product|
      product.resources :service_contracts, :member => {:select => :post, :remove => :post}, :collection => {:available => :post, :selected => :get}
    end
end     
