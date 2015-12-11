
module Grafana

  module Organization

    def get_current_org()
      endpoint = "/api/org"
      @logger.info("Getting current organization (GET #{endpoint})") if @debug
      return get_request(endpoint)
    end

    def update_current_org(properties={})
      endpoint = "/api/org"
      @logger.info("Updating current organization (PUT #{endpoint})") if @debug
      return put_request(endpoint, properties)
    end

    def get_current_org_users()
      endpoint = "/api/org/users"
      @logger.info("Getting organization users (GET #{endpoint})") if @debug
      return get_request(endpoint)
    end

    def add_user_to_current_org(properties={})
      endpoint = "/api/org/users"
      @logger.info("Adding user to current organization (POST #{endpoint})") if @debug
      return post_request(endpoint, properties)
    end


  end

end
