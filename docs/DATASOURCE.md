
## Datasource Related API Methods
---

The following methods are all relating to data sources


##### Get all current data sources: 
```ruby
g.get_data_sources()
```

##### Get the CloudWatch namespaces for a given CloudWatch data source id:
```ruby
g.get_cw_namespaces(23)
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

##### Update a data source:
```ruby
g.update_data_source({
  "id": 1,
  "orgId": 1,
  "name": "test_datasource",
  "type": "graphite",
  "access": "proxy",
  "url": "http://mydatasource.com",
  "password": "",
  "user": "",
  "database": "",
  "basicAuth": true,
  "basicAuthUser": "basicuser",
  "basicAuthPassword": "basicuser",
  "isDefault": false,
  "jsonData": null
})
```

##### Delete a data source:
```ruby
g.delete_data_source(23)
```
