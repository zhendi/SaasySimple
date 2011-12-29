$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "SaasySimple/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "saasy_simple"
  s.version     = SaasySimple::VERSION
  s.authors     = ["Jonathan Jeffus"]
  s.email       = ["jjeffus@gmail.com"]
  s.homepage    = "http://github.com/jjeffus/SaasySimple"
  s.summary     = "Allows your app to become a SaaS via SaaSy."
  s.description = "This is a rails engine that implements SaaSy/FastSpring's interface for selling your app as a service."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1"
end
