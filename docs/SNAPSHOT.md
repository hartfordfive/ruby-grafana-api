
## Snapshot Methods
---

##### Create a snapshot for a given dahsboard: 
```ruby
g.create_snapshot({
  "dashboard": {
    "editable":false,
    "hideControls":true,
    "nav":[
    {
      "enable":false,
    "type":"timepicker"
    }
    ],
    "rows": [
      {

      }
    ],
    "style":"dark",
    "tags":[],
    "templating":{
      "list":[
      ]
    },
    "time":{
    },
    "timezone":"browser",
    "title":"Home",
    "version":5
    },
  "expires": 3600
})
```

##### Get snapshot: 
```ruby
g.get_snapshot('snapshot-key')
```

##### Delete snapshot: 
```ruby
g.delete_snapshot('snapshot-key')
```
