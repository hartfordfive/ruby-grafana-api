## Admin Related API Methods
---

The following methods are all relating to Grafana administration


##### Get current admin settings:
```ruby
g.get_admin_settings()
```

##### Update a user's permissions:
```ruby
# Give user global admin privilege in Grafana
g.update_user_permissions(6, {"isGrafanaAdmin" => false})

# Give user admin privilege in their current organization
g.update_user_permissions(6, "Admin")
```

##### Deleting a user:
```ruby
g.delete_user(6)
```

##### Creating a user:
```ruby
g.create_user({
  "name": "User",
  "email": "user@graf.com",
  "login": "user",
  "password": "userpassword"
})
```

##### Updating user password:
```ruby
g.update_user_pass(6, 'VerySecretPassword')
```

