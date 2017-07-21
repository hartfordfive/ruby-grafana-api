
module Grafana

  module Users

    def get_all_users()
      endpoint = "/api/users"
      @logger.info("Getting all users (GET #{endpoint})") if @debug
      return get_request(endpoint)
    end

    def get_user_by_id(id)
      endpoint = "/api/users/#{id}"
      @logger.info("Getting user ID #{id} (GET #{endpoint})") if @debug
      return get_request(endpoint)
    end

    def search_for_users_by(search={})
      all_users = self.get_all_users()
      key, value = search.first
      @logger.info("Searching for users matching #{key} = #{value}") if @debug
      users = []
      all_users.each do |u|
        if u[key] && u[key] == value
          users.push(u)
        end
      end
      return (users.length >= 1 ? users : false)
    end

    def update_user_info(id, properties={})
      endpoint = "/api/users/#{id}"
      @logger.info("Updating user ID #{id}") if @debug
      existing_user = self.get_user(id)
      if !existing_user
        @logger.error("User #{id} does not exist") if @debug
        return false
      end
      properties = existing_user.merge(properties)
      return put_request(endpoint,properties.to_json)
    end

    def get_user_orgs(userid)
      endpoint = "/api/users/#{userid}/orgs"
      @logger.info("Getting organizations for user #{userid} (GET #{endpoint})") if @debug
      return get_request(endpoint)
    end

  end

end
