require 'digest/md5'

module SaasySimple
  class Configuration
    attr_accessor :store_page_url, :secret, :username, :password, :model
    def initialize
      @store_page_url = 'http://localhost:3001/store'
      @secret         = 'some_secret'
      @username       = 'jack'
      @password       = 'jill'
      @model          = User
    end
  end
  class SubscriptionsController < ApplicationController
    def activate
      logger.info "Activate: "+params.inspect
      if Digest::MD5.hexdigest(params["security_data"] + SaasySimple.config.secret) == params["security_hash"]
        logger.info "Success: Validated"
        SaasySimple.config.model.activate( params['token'], params['referrer'] )
      else
        logger.info "activate: Failed: Validation"
      end
    end

    def billing
      return unless current_user
      redirect_to "#{SaasySimple.config.store_page_url}?referrer=#{current_user.id}"
    end

    def deactivate
      logger.info "Deactivate: "+params.inspect
      if Digest::MD5.hexdigest(params["security_data"] + APP.config.secret) == params["security_hash"]
        logger.info "Success: Validated"
        SaasySimple.config.model.deactivate( params['token'], params['referrer'] )
      else
        logger.info "activate: Failed: Validation"
      end
    end
  end
end
