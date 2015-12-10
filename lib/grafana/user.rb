
module Grafana

  module User

    def get_current_user()
      endpoint = "/api/user"
      @logger.info("Getting user ID #{id} (GET #{endpoint})") if @debug
      return get_request(endpoint)
    end

    def change_current_user_pass(properties={})
      endpoint = "/api/user/password"
      @logger.info("Updating current user password (PUT #{endpoint})") if @debug
      return put_request(endpoint,properties)
    end

    def create_user(properties={})
      endpoint = "/api/admin/users"
      @logger.info("Creating user: #{properties['name']}") if @debug
      @logger.info("Data: #{properties.to_s}") if @debug
      return post_request(endpoint, properties.to_json)
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

    def update_user_permissions(id, perm)

      valid_perms = ['Viewer','Editor','Read Only Editor','Admin']

      if perm.class.to_s == "String" && !valid_perms.include?(perm)
        @logger.warn("Basic user permissions include: #{valid_perms.join(',')}") if @debug
        return false
      elsif perm.class.to_s == "Hash" &&
        ( !perm.has_key?('isGrafanaAdmin') || ![true,false].include?(perm['isGrafanaAdmin']) )
        @logger.warn("Grafana admin permission must be either true or false") if @debug
        return false
      end

      @logger.info("Updating user ID #{id} permissions") if @debug

      if perm.class.to_s == 'Hash'
        endpoint = "/api/admin/users/#{id}/permissions"
        @logger.info("Updating user ID #{id} permissions (PUT #{endpoint})") if @debug
        return put_request(endpoint, {"isGrafanaAdmin" => perm['isGrafanaAdmin']}.to_json)
      else
        org = self.get_current_org()
        endpoint = "/api/orgs/#{org['id']}/users/#{id}"
        @logger.info("Updating user ID #{id} permissions (PUT #{endpoint})") if @debug
        user = { 
          'name' => org['name'], 
          'orgId' => org['id'], 
          'role' => perm.downcase.capitalize
        }
        return patch_request(endpoint, user.to_json)
      end
    end

    def delete_user(id)
      if id == 1
        @logger.warn("Can't delete user ID #{id} (admin user)") if @debug
        return false
      end
      endpoint = "/api/admin/users/#{id}"
      @logger.info("Deleting user ID #{id} (DELETE #{endpoint})") if @debug
      return delete_request(endpoint)
    end

    def ping_session()
      endpoint = "/api/login/ping"
      @logger.info("Pingning current session (GET /api/login/ping)") if @debug
      return get_request(endpoint)
    end

  end

end
