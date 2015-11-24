Gem::Specification.new do |s|
  s.name        = 'grafana-api'
  s.version     = '0.1.0'
  s.date        = '2015-11-24'
  s.summary     = "Grafana HTTP API Wrapper"
  s.description = "A simple wrapper for the Grafana HTTP API"
  s.authors     = ["Alain Lefebvre"]
  s.email       = 'devtools@lightspeedpos.com'
  s.files       = [
    "lib/grafana.rb", 
    'lib/grafana/client.rb',
    'lib/grafana/dashboard.rb',
    'lib/grafana/dashboard_template.rb',
    'lib/grafana/datasource.rb', 
    'lib/grafana/organization.rb',
    'lib/grafana/user.rb',
    'lib/grafana/version.rb',
  ]
  s.homepage    = 'http://github.com/lightspeedretail/ruby-grafana-api'
  s.license     = 'MIT'
  s.add_runtime_dependency 'json',         '~> 1.7'
  s.add_runtime_dependency 'rest-client',  '~> 1.8'
end
