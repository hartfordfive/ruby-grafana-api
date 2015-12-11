
## User API Methods
---
The following methods are all relating to the active user

##### Get the current user: 
```ruby
g.get_current_user()
```

##### Update current user's password:
```ruby
g.upate_current_user_pass({
  "oldPassword": "old_password",
  "newPassword": "new_password",
  "confirmNew": "confirm_new_password"
})
```

##### Switch user to a given org in the current session:
```ruby
g.switch_current_user_org(2)
```

##### Getting all organizations a user belongs to: 
```ruby
g.get_current_user_orgs()
```

##### Adding a given dashboard for the current user's favorites: 
```ruby
g.add_dashboard_star(DASHBOARD_ID)
```

##### Removing a given dashboard for the current user's favorites: 
```ruby
g.remove_dashboard_star(DASHBOARD_ID)
```




