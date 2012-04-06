require 'digest/md5'
require 'open-uri'

module SaasySimple
  class SubscriptionsController < ApplicationController
    def activate
      if Digest::MD5.hexdigest(params["security_data"] + SaasySimple.config.secret) == params["security_hash"]
        SaasySimple.config.model.activate( params['token'], params['id'] )
      end
    end

    def billing
      return unless current_user
      if current_user.status == 'active'
        subscription = SaasySimple.subscription(current_user)
        redirect_to subscription['customerUrl']
      else
        redirect_to SaasySimple.signup(current_user)
      end
    end

    def change
      if Digest::MD5.hexdigest(params["security_data"] + SaasySimple.config.c_secret) == params["security_hash"]
        unless params["SubscriptionEndDate"].blank?
          SaasySimple.config.model.cancel( params['token'], params['id'] )
        end
      end
    end
    
    def deactivate
      if Digest::MD5.hexdigest(params["security_data"] + SaasySimple.config.d_secret) == params["security_hash"]
        SaasySimple.config.model.deactivate( params['token'], params['id'] )
      end
    end
  end
end
