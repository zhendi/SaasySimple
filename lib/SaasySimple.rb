require "SaasySimple/engine"

module SaasySimple
  def self.config(&block)
    @@config ||= SaasySimple::Configuration.new

    yield @@config if block

    return @@config
  end

  def self.subscription(user)
    s = {}
    if user.status == 'active'
      x = open(
        "https://api.fastspring.com/company/" +
        SaasySimple.config.store_id +
        "/subscription/" + user.token +
        "?user="         + SaasySimple.config.username +
        "&pass="         + SaasySimple.config.password
      )
      xml = x.read
      nok = Nokogiri::XML(xml)
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
