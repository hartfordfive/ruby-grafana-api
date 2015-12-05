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

### User Methods
---
The following methods are all relating to users

##### Getting a list of users: 
```ruby
g.get_users()
```

##### Getting a specific user by ID: 
```ruby
g.get_user(1)
```

##### Creating a user in the current organization: 
```ruby
g.create_user({
  "name" => "John Doe",
  "email" => "johndoe@youremail.com",
  "login" => "jdoe",
  "password" => "jdoe123" 
})
```

##### Updating user permissions: 
```ruby
# Give user global admin privilege in Grafana
g.update_user_permissions(6, {"isGrafanaAdmin" => false})
# Give user admin privilege in their current organization
g.update_user_permissions(6, "Admin")
```
##### Updating user info: 
```ruby
g.update_user_info(2, {"email" => "anewemail@yourdomain.com"})
```

##### Deleting a user by ID: 
```ruby
g.delete_user(6)
```

##### Search for users by a given property: 
```ruby
# Example, search for user by username:
g.search_for_users_by({"login" => "jdoe"})
# or by email:
g.search_for_users_by({"email" => "johndoe@youremail.com"})
```

### Datasource Methods
---
The following methods are all relating to data sources

##### Get all current data sources: 
```ruby
g.get_data_sources()
```

##### Create a data source: 
```ruby
g.create_data_source(
    {
      "access" => "proxy",
      "name" => "cloudwatch_metrics_us-east-1",
      "database" => "metrics_us-east-1",
      "type" => "cloudwatch",
      "jsonData" => { "defaultRegion" => "us-east-1"}
    }
)
```

##### Get available data source types: 
```ruby
g.get_available_data_source_types()
```


### Dashboard Methods
---
The following methods are all relating to dashboards

##### Get a dashboard:
```ruby
g.get_dashboard('Main Dashboard') # converted to 'main-dashboard' automatically
```

##### Creating a dashboard: 
```ruby
g.create_dashboard({
  "title" => "API Created Dashboard",
  "from" => "now-30m",
  "to" => "now",
  "panels" => [
    {
      "datasource" => "cloudwatch_production_us-east-1",
      "graph_title" => "EC2 Instance CPU",
      "targets" => [
        {
          "metric_name" => "CPUUtilization",
          "namespace" => "AWS/EC2",
          "dimension_name" => "InstanceId",
          "dimension_value" => "i-07abc123",
          "region" => "us-east-1",
          "legend_alias" => "Instance #1 {{metric}} {{stat}}"
        },
        {
          "metric_name" => "CPUUtilization",
          "namespace" => "AWS/EC2",
          "dimension_name" => "InstanceId",
          "dimension_value" => "i-07abc124",
          "region" => "us-east-1",
          "legend_alias" => "Instance #2 {{metric}} {{stat}}"
        },
        {
          "metric_name" => "CPUUtilization",
          "namespace" => "AWS/EC2",
          "dimension_name" => "InstanceId",
          "dimension_value" => "i-07abc125",
          "region" => "us-east-1",
          "legend_alias" => "Instance #3 {{metric}} {{stat}}"
        }
      ]
    }
  ]
})
```

##### Get the CloudWatch namespaces for a given CloudWatch data source id:
```ruby
g.get_cw_namespaces(23)
```

##### Delete a dashboard:
```ruby
g.delete_dashboard('Main Dashboard')
```

##### Get the home dashboard:
```ruby
g.get_home_dashboard()
```

##### Get dashboard tags:
```ruby
g.get_dashboard_tags()
```

##### Search for dashboard:
```ruby
g.search_dashboards({"query" => "My Dashboard", "tags" => 'test'})
```


### Snapshot Methods
---

##### Create snapshot: (TODO)
```ruby
g.create_snapshot()
```

##### Get snapshot: (TODO)
```ruby
g.get_snapshot()
```

##### Delete snapshot: (TODO)
```ruby
g.delete_snapshot()
```


## License

Covered by the MIT [license](LICENSE).
