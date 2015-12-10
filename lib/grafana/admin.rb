
module Grafana

  module Admin

    def get_admin_settings()
      endpoint = "/api/admin/settings"
      @logger.info("Getting admin settings (GET #{endpoint})") if @debug
      return get_request(endpoint)
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

    def create_user(properties={})
      endpoint = "/api/admin/users"
      @logger.info("Creating user: #{properties['name']}") if @debug
      @logger.info("Data: #{properties.to_s}") if @debug
      return post_request(endpoint, properties.to_json)
    end

    def update_user_pass(user_id)
      endpoint = " /api/admin/users/#{user_id}/password"
      @logger.info("Updating password for user ID #{user_id} (PUT #{endpoint})") if @debug
      return put_request(endpoint,properties)
    end

    def update_user_permissions(properties={})
      endpoint = " /api/admin/users/#{user_id}/permissions"
      @logger.info("Updating permissions for user ID #{user_id} (PUT #{endpoint})") if @debug
      return put_request(endpoint,properties)
    end

    def delete_user(user_id)
      endpoint = "/api/admin/users/#{user_id}"
      @logger.info("Deleting user ID #{user_id} (DELETE #{endpoint})") if @debug
      return delete_request(endpoint)
    end

  end

end
