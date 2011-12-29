require "SaasySimple/engine"

module SaasySimple
  def self.config(&block)
    @@config ||= SaasySimple::Configuration.new

    yield @@config if block

    return @@config
  end
end
