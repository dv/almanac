$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "almanac/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "almanac"
  s.version     = Almanac::VERSION
  s.authors     = ["David Verhasselt"]
  s.email       = ["david@crowdway.com"]
  s.homepage    = "https://github.com/dv/almanac"
  s.summary     = "A high-level logging and auditing gem."
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.require_paths = ["lib"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3"

  s.add_development_dependency "sqlite3"
end
