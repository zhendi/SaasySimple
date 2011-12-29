SaasySimple::Engine.routes.draw do
  post "subscriptions/activate",   :controller => 'subscriptions', :action => 'activate'
  get  "subscriptions/billing",    :controller => 'subscriptions', :action => 'billing'
  post "subscriptions/deactivate", :controller => 'subscriptions', :action => 'deactivate'
end
