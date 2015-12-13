## Organizations Related API Methods
---

The following methods are all relating to Grafana organizations


##### Get all orgnaizations:
```ruby 
g.get_all_orgs()
```

##### Update a given organization:
```ruby
g.update_org(ORG_ID, {
  "name": "Main Org 2."
})
```

##### Get all users in a specific orgnaization:
```ruby
g.get_org_users(ORG_ID)
```

##### Add a user to given orgnaization:
```ruby
g.add_user_to_org(ORG_ID, {
  "loginOrEmail": "testuser",
  "role": "Viewer"
})
```

##### Update a user property within a specific organization:
```ruby
g.update_org_user(ORG_ID, USER_ID, {
  "role":"Admin"
})
```

##### Remove a user from a given orgnaization:
```ruby
g.delete_user_from_org(ORG_ID, USER_ID)
```
