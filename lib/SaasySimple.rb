require "SaasySimple/engine"
require 'net/https'
require 'uri'

module SaasySimple
  def self.config(&block)
    @@config ||= SaasySimple::Configuration.new

    yield @@config if block

    return @@config
  end

  def self.subscription(user)
    s = {}
    if user.status == 'active'
      url = "https://api.fastspring.com/company/" +
            SaasySimple.config.store_id +
            "/subscription/" + user.token +
            "?user="         + SaasySimple.config.username +
            "&pass="         + SaasySimple.config.password
      uri              = URI.parse(url)
      http             = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl     = true
      http.ca_file     = SaasySimple::Engine.root.join("config/cacert.pem").to_s
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      request          = Net::HTTP::Get.new(uri.request_uri)
      response         = http.request(request)
      xml              = response.body
      nok              = Nokogiri::XML(xml)
      s['nextPeriodDate'] = nok.xpath("//nextPeriodDate").text if nok.xpath("//nextPeriodDate")
      s['status']         = nok.xpath("//status").text         if nok.xpath("//status")
      s['customerUrl']    = nok.xpath("//customerUrl").text    if nok.xpath("//customerUrl")
    end
    s
  end

  def self.cancel(user)
    s = {}
    if user.status == 'active'
      url = "https://api.fastspring.com/company/" +
            SaasySimple.config.store_id +
            "/subscription/" + user.token +
            "?user="         + SaasySimple.config.username +
            "&pass="         + SaasySimple.config.password
      uri              = URI.parse(url)
      http             = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl     = true
      http.ca_file     = SaasySimple::Engine.root.join("config/cacert.pem").to_s
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      request          = Net::HTTP::Delete.new(uri.request_uri)
      response         = http.request(request)
      xml              = response.body
      nok              = Nokogiri::XML(xml)
      s['nextPeriodDate'] = nok.xpath("//nextPeriodDate").text if nok.xpath("//nextPeriodDate")
      s['status']         = nok.xpath("//status").text         if nok.xpath("//status")
      s['customerUrl']    = nok.xpath("//customerUrl").text    if nok.xpath("//customerUrl")
    end
    s
  end

  def self.signup(user)
    "#{SaasySimple.config.url}?referrer=#{user.id}"
  end
end
