Rails.application.routes.draw do
  post "saasy/subscriptions/activate",   :controller => 'subscriptions', :action => 'activate'
  get  "saasy/subscriptions/billing",    :controller => 'subscriptions', :action => 'billing'
  post "saasy/subscriptions/deactivate", :controller => 'subscriptions', :action => 'deactivate'
end
