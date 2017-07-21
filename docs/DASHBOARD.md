
## Dashboard Related API Methods
---

The following methods are all relating to dashboards


##### Get a dashboard:
```ruby
g.get_dashboard('Main Dashboard') # converted to 'main-dashboard' automatically
```

##### Get a dashboard list:
```ruby
g.get_dashboard_list() # No parameter is required
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
