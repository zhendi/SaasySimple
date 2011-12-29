module SaasySimple
  class SubscriptionsController < ApplicationController
    def activate
      logger.info "Activate: "+params.inspect
    end

    def billing
      logger.info "Billing: "+params.inspect
      redirect_to 'http://sites.fastspring.com/albumdraft/product/albumdraft?referrer='+current_user.id
    end

    def deactivate
      logger.info "Deactivate: "+params.inspect
    end
  end
end
