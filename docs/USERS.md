## Users API Methods
---
The following methods are all relating to global users

##### Get all users: 
```ruby
g.get_all_users()
```

##### Get a user by ID: 
```ruby
g.get_user_by_id(USER_ID)
```

##### Search for users by a given property: 
```ruby
# Example, search for user by username:
g.search_for_users_by({"login" => "jdoe"})
# or by email:
g.search_for_users_by({"email" => "johndoe@youremail.com"})
```

##### Updating user info: 
```ruby
g.update_user_info(USER_ID, {"email" => "anewemail@yourdomain.com"})
```

##### Getting a given user's organizations: 
```ruby
g.get_user_orgs(USER_ID)
```

