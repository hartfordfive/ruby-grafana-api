## Organization Related API Methods
---

The following methods are all relating to Grafana administration


##### Get ognaization for current user:
```ruby
g.get_current_org()
```

##### Update properties of the current organization:
```ruby
g.update_current_org({
  "name": "Main Org."
})
```

##### Get users in current organizations:
```ruby
g.get_current_org_users()
```

##### Add a global user to the current orgnaization:
```ruby
g.add_user_to_current_org({
  "role": "Admin",
  "loginOrEmail": "jdoe"
})
```
