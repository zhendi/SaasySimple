Rails.application.routes.draw do
  namespace :saasy_simple do
    post "subscriptions/activate",   :controller => 'subscriptions', :action => 'activate'
    get  "subscriptions/billing",    :controller => 'subscriptions', :action => 'billing'
    post "subscriptions/deactivate", :controller => 'subscriptions', :action => 'deactivate'
  end
end
