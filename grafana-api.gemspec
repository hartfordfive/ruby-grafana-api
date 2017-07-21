Gem::Specification.new do |s|
  s.name        = 'grafana-api'
  s.version     = '0.2.0'
  s.date        = '2017-07-20'
  s.summary     = "Grafana HTTP API Wrapper"
  s.description = "A simple wrapper for the Grafana HTTP API"
  s.authors     = ["Alain Lefebvre"]
  s.email       = 'alain.lefebvre@gmail.com'
  s.files       = ["lib/grafana.rb"] + Dir["lib/grafana/*"]
  s.homepage    = 'http://github.com/hartfordfive/ruby-grafana-api'
  s.license     = 'MIT'
  s.add_runtime_dependency 'json',         '~> 1.7'
  s.add_runtime_dependency 'rest-client',  '~> 1.8'
end
