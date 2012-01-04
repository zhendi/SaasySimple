require 'digest/md5'
require 'open-uri'

module SaasySimple
  class SubscriptionsController < ApplicationController
    def activate
      logger.info "Activate: "+params.inspect
      if Digest::MD5.hexdigest(params["security_data"] + SaasySimple.config.secret) == params["security_hash"]
        logger.info "Success: Validated"
        SaasySimple.config.model.activate( params['token'], params['id'] )
      else
        logger.info "activate: Failed: Validation"
      end
    end

    def billing
      return unless current_user
      if current_user.status == 'active'
        xml = open(
          "https://api.fastspring.com/company/" +
          SaasySimple.config.store_id +
          "/subscription/" + current_user.token +
          "?user=" + SaasySimple.config.username +
          "&pass=" + SaasySimple.config.password
        ).read
        logger.info "XML"+xml
        doc = Nokogiri::XML(xml)
        render SaasySimple.config.view
      else
        redirect_to "#{SaasySimple.config.url}?referrer=#{current_user.id}"
      end
    end

    def deactivate
      logger.info "Deactivate: "+params.inspect
      if Digest::MD5.hexdigest(params["security_data"] + APP.config.secret) == params["security_hash"]
        logger.info "Success: Validated"
        SaasySimple.config.model.deactivate( params['token'], params['id'] )
      else
        logger.info "activate: Failed: Validation"
      end
    end
  end
end
