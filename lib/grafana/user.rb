
module Grafana

  module User

    def get_current_user()
      endpoint = "/api/user"
      @logger.info("Getting user ID #{id} (GET #{endpoint})") if @debug
      return get_request(endpoint)
    end

    def update_current_user_pass(properties={})
      endpoint = "/api/user/password"
      @logger.info("Updating current user password (PUT #{endpoint})") if @debug
      return put_request(endpoint,properties)
    end

    def switch_current_user_org(org_id)
      endpoint = "/api/user/using/#{org_id}"
      @logger.info("Switching current user to Org ID #{id} (GET #{endpoint})") if @debug
      return post_request(endpoint, {})
    end

    def get_current_user_orgs()
      endpoint = "/api/user/orgs"
      @logger.info("Getting current user organizations (GET #{endpoint})") if @debug
      return get_request(endpoint)
    end

    def add_dashboard_star(dashboard_id)
      endpoint = "/api/user/stars/dashboard/#{dashboard_id}"
      @logger.info("Adding start to dashboard ID #{dashboard_id} (GET #{endpoint})") if @debug
      return post_request(endpoint, {})
    end

    def remove_dashboard_star(dashboard_id)
      endpoint = "/api/user/stars/dashboard/#{dashboard_id}"
      @logger.info("Deleting start on dashboard ID #{dashboard_id} (GET #{endpoint})") if @debug
      return delete_request(endpoint)
    end

    def ping_session()
      endpoint = "/api/login/ping"
      @logger.info("Pingning current session (GET /api/login/ping)") if @debug
      return get_request(endpoint)
    end

  end

end
