Gem::Specification.new do |s|
  s.name        = 'grafana-api'
  s.version     = '0.0.1'
  s.date        = '2015-11-13'
  s.summary     = "Grafana API Wrapper"
  s.description = "A simple wrapper for the Grafana HTTP API"
  s.authors     = ["Alain Lefebvre"]
  s.email       = 'devtools@lightspeedpos.com'
  s.files       = ["lib/grafana-api.rb"]
  s.homepage    = 'http://github.com/lightspeedretail/ruby-grafana-api'
  s.license     = 'MIT'
  s.add_runtime_dependency 'json',         '~> 1.7'
  s.add_runtime_dependency 'rest-client',  '~> 1.8'
end