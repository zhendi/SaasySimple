Rails.application.routes.draw do
  namespace :saasy_simple do
    post "saasy/subscriptions/activate",   :controller => 'subscriptions', :action => 'activate'
    get  "saasy/subscriptions/billing",    :controller => 'subscriptions', :action => 'billing'
    post "saasy/subscriptions/deactivate", :controller => 'subscriptions', :action => 'deactivate'
  end
end
