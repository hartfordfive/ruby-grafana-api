# ruby-grafana-api

## Description

A simple Ruby wrapper for the [Grafana](http://docs.grafana.org/reference/http_api/)  HTTP API.  To include in your project, simply require the grafana library:

```ruby
require 'grafana'
```

## Comments/Notes

This project is still in its infancy stages therefore only a small portion of the overall Grafana HTTP API methods have been implemented. If you come across a bug or if you have a request for a new feature, please open an issue.


## Methods & Usage Examples

#### Creating an instance of the grafana api client: 
```ruby
options = {"debug" => false, "timeout" => 3, "ssl" => false}
g = Grafana::Client.new('[GRAFANA_HOST]', [GRAFANA_PORT], '[GRAFANA_USER]', '[GRAFANA_PASS]', options)
```

#### Individual Module Documentation

* [Admin](docs/ADMIN.md) 
* [Dashboard](docs/DASHBOARD.md) 
* [Datasource](docs/DATASOURCe.md) 
* [Frontend](docs/FRONTEND.md) 
* [Login](docs/LOGIN.md) 
* [Organization](docs/ORGANIZATION.md) 
* [Organizations](docs/ORGANIZATIONS.md) 
* [Snapshot](docs/SNAPSHOT.md) 
* [User](docs/USER.md) 
* [Users](docs/USERS.md) 


## License

Covered by the MIT [license](LICENSE).
