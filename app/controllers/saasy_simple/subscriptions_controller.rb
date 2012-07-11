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
      price = cal_price(current_user)
      if current_user.status == 'active'
        subscription = SaasySimple.subscription(current_user)
        redirect_to subscription['customerUrl']+"&tags=total=#{price*100}"
      else
        redirect_to SaasySimple.signup(current_user)+"&tags=total=#{price*100}"
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
    
    private
    
    def cal_price(user)
      al = []
      site_price = 5
      user_price = 2.5
      gateway_price = 10
      device_price = 4.5
      message_price = 0.03
      
      user_count = User.where(:created_by=>current_user.id).count + 1
      gateway_count, device_count, message_count, site_count = 0, 0, 0, 0
      UserGateway.where(:user_id=>user.id).each do |ug|
        site = ug["zone"].blank? ? ug["mac"] : ug["zone"]
        next if al.include?(site)
        site_count += 1
        al << site
        gateway_count += 1
        registered_gateway = RegisteredGateway.where(:mac=>ug['mac']).first
        latest_timestamp = registered_gateway.devices.where(:timestamp.exists=>true).order_by([[:timestamp, -1]]).limit(1).first.timestamp rescue nil
        latest_timestamp = Time.parse(latest_timestamp).advance(:minutes => -5).strftime("%Y%m%d%H%M%S") if latest_timestamp
        device_count += registered_gateway.devices.where(:timestamp.gte => latest_timestamp).count
        message_count += Message.where(:mac=>ug['mac']).count
      end   
      site_count*site_price + user_count*user_price + gateway_count*gateway_price + device_count*device_price + message_count*message_price
    end
  end
end
