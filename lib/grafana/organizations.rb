
module Grafana

  module Organizations

    def get_all_orgs()
      endpoint = "/api/orgs"
      @logger.info("") if @debug

    end


    def update_org(org_id)
      endpoint = "/api/orgs/#{org_id}"
      @logger.info("") if @debug

    end

    def get_org_users(org_id)
      endpoint = "/api/orgs/#{org_id}/users"
      @logger.info("") if @debug

    end


    def add_user_to_org(org_id, user={}) 
      endpoint = "/api/orgs/#{org_id}/users"
      @logger.info("") if @debug
      
    end

    def update_org_user(org_id, user_id, user={})
      endpoint = "/api/orgs/#{org_id}/users/#{user_id}"
      @logger.info("Updating user #{user_id} in organization #{org_id} (PATCH #{endpoint})") if @debug
      return patch_request(endpoint, user)
    end

    def delete_org_user(org_id, user_id)
      endpoint = "/api/orgs/#{org_id}/users/#{user_id}"
      @logger.info("Deleting user #{user_id} in organization #{org_id} (DELETE #{endpoint})") if @debug
      return delete_request(endpoint)
    end

  end

end
