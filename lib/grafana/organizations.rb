
module Grafana

  module Organizations

    def get_all_orgs()
      endpoint = "/api/orgs"
      @logger.info("Getting all organizations (GET #{endpoint})") if @debug
      return get_request(endpoint)
    end


    def update_org(org_id, properties={})
      endpoint = "/api/orgs/#{org_id}"
      @logger.info("Updating orgnaization ID #{org_id} (POST #{endpoint})") if @debug
      return post_request(endpoint, properties)
    end

    def get_org_users(org_id)
      endpoint = "/api/orgs/#{org_id}/users"
      @logger.info("Getting users in orgnaization ID #{org_id} (GET #{endpoint})") if @debug
      return get_request(endpoint)
    end


    def add_user_to_org(org_id, user={}) 
      endpoint = "/api/orgs/#{org_id}/users"
      @logger.info("Adding user to orgnaization ID #{org_id} (POST #{endpoint})") if @debug
      return post_request(endpoint, user)
    end

    def update_org_user(org_id, user_id, properties={})
      endpoint = "/api/orgs/#{org_id}/users/#{user_id}"
      @logger.info("Updating user #{user_id} in organization #{org_id} (PATCH #{endpoint})") if @debug
      return patch_request(endpoint, properties)
    end

    def delete_user_from_org(org_id, user_id)
      endpoint = "/api/orgs/#{org_id}/users/#{user_id}"
      @logger.info("Deleting user #{user_id} in organization #{org_id} (DELETE #{endpoint})") if @debug
      return delete_request(endpoint)
    end

  end

end
