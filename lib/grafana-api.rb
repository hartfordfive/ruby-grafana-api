class GrafanaApi

  require 'rest-client'
  require 'json'
  require 'logger'

  attr_accessor :debug, :session_cookies, :headers

  def initialize(host="localhost", port=3000, debug=false)
    @api_instance = RestClient::Resource.new("http://#{host}:#{port}")
    @debug = debug
    @logger = Logger.new(STDOUT)
    @headers = nil
  end

  def login(user='admin',pass='admin')
    @logger.info("Attempting to establish user session") if @debug
    request_data = {'User' => user, 'Password' => pass}
    begin
      resp = @api_instance['/login'].post(
        request_data.to_json, 
        {:content_type => 'application/json; charset=UTF-8'}
      )
      @session_cookies = resp.cookies
      if resp.code.to_i == 200
        @headers = {
          :content_type => 'application/json; charset=UTF-8',
          :cookies => @session_cookies
        }
        return true
      else
        return false
      end
    rescue => e
      @logger.error("Error running POST request on /login: #{e}") if @debug
      @logger.error("Request data: #{request_data.to_json}") if @debug
      return false
    end
    @logger.info("User session initiated") if @debug
  end



  def get_user(id)
    @logger.info("Getting user ID #{id} (GET /api/users/#{id})") if @debug
    begin
      resp = @api_instance["/api/users/#{id}"].get(@headers)
      if resp.code.to_i == 200
        return JSON.parse(resp.body)
      else
        @logger.error("Could not get user: #{resp.body}") if @debug
        return false
      end
    rescue => e
     @logger.error("Could not get user: #{e}") if @debug
     return false
    end
  end

  def get_users()
    @logger.info("Getting all users (GET /api/users)") if @debug
    begin
      resp = @api_instance['/api/users'].get(@headers)
      if resp.code.to_i == 200
        return JSON.parse(resp.body)
      else
        @logger.error("Could not get list of users: #{resp.body}") if @debug
        return false
      end
    rescue => e
     @logger.error("Could not get list of users: #{e}") if @debug
     return false
    end
  end

  def search_for_users_by(search={})
    all_users = self.get_users()
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

  def create_user(properties={})
    @logger.info("Creating user: #{properties['name']}") if @debug
    @logger.info("Data: #{properties.to_s}") if @debug
    begin
      resp = @api_instance["/api/admin/users"].post(
        properties.to_json,
        @headers
      )
      result = JSON.parse(resp.body)
      if resp.code.to_i == 200
        @logger.info(resp.body) if @debug
        return true
      else
        @logger.error("Data source could not be created: #{resp.body}") if @debug
        return false
      end
    rescue => e
      @logger.error("Error creating data source: #{e}") if @debug
      return false
    end
  end

  def update_user_info(id, properties={})
    @logger.info("Updating user ID #{id}") if @debug
    begin
      existing_user = self.get_user(id)
      if !existing_user
        @logger.error("User #{id} does not exist") if @debug
        return false
      end
      properties = existing_user.merge(properties)
      resp = @api_instance["/api/users/#{id}"].put(
        properties.to_json,
        @headers
      )
      if resp.code.to_i == 200
        return JSON.parse(resp.body)
      else
        @logger.error("Could not update user (HTTP #{resp.code}: #{resp.body})") if @debug
        return false
      end
    rescue => e
      @logger.error("Could not update user: #{e}") if @debug
      return false
    end
  end

  def update_user_permissions(id, perm)

    valid_perms = ['Viewer','Editor','Read Only Editor','Admin']

    if perm.class.to_s == "String" && 
      !valid_perms.include?(perm)
      @logger.warn("Basic user permissions include: #{valid_perms.join(',')}") if @debug
      return false
    elsif perm.class.to_s == "Hash" &&
      (!perm.has_key?('isGrafanaAdmin') ||
        ![true,false].include?(perm['isGrafanaAdmin']) )
      @logger.warn("Grafana admin permission must be either true or false") if @debug
      return false
    end

    @logger.info("Updating user ID #{id} permissions") if @debug
    begin
      if perm.class.to_s == 'Hash'
        resp = @api_instance["/api/admin/users/#{id}/permissions"].put(
          {"isGrafanaAdmin" => perm['isGrafanaAdmin']}.to_json,
          @headers
        )
      else
        org = self.get_current_org()
        resp = @api_instance["/api/orgs/#{org['id']}/users/#{id}"].patch(
          { 'name' => org['name'], 'orgId' => org['id'], 
            'role' => perm.downcase.capitalize
          }.to_json,
          @headers
        )
      end

      if resp.code.to_i == 200
        @logger.error("User permissions have been updated: #{resp.body}") if @debug
        return true
      else
        @logger.error("Could not update user permissions (HTTP #{resp.code}: #{resp.body})") if @debug
        return false
      end
    rescue => e
      @logger.error("Could not update user permissions: #{e}") if @debug
      return false
    end
  end

  def delete_user(id)
    if id == 1
      @logger.warn("Can't delete user ID #{id} (admin user)") if @debug
      return false
    end
    @logger.info("Deleting user ID #{id} (DELETE /api/admin/users/#{id})") if @debug
    begin
      resp = @api_instance["/api/admin/users/#{id}"].delete(@headers)
      if resp.code.to_i == 200
        @logger.info("User ID #{id} has been deleted") if @debug
        return true
      else
        @logger.error("Could note delete: #{resp.body}") if @debug
        return false
      end
    rescue => e
     @logger.error("Could not delete user: #{e}") if @debug
     return false
    end
  end



  def get_data_sources()
    begin 
      @logger.info("Attempting to get existing data sources (GET /api/datasources)") if @debug
      resp = @api_instance['/api/datasources'].get(@headers)
      data_sources = JSON.parse(resp.body)
      data_source_map = {}
      data_sources.each { |ds|
        data_source_map[ds['id']] = ds
      }
      if resp.code.to_i == 200
        return data_source_map
      else
        @logger.error("Could not retreive data sources (HTTP #{resp.code}: #{resp.body})") if @debug
        return false
      end
    rescue => e
      @logger.error("Error getting existing data sources: #{e}") if @debug
      return false
    end
  end 

  def get_data_source(id)
    begin 
      @logger.info("Attempting to get existing data source ID #{id}") if @debug
      resp = @api_instance["/api/datasources/#{id}"].get(@headers)
      if resp.code.to_i == 200
        return JSON.parse(resp.body)
      else
        @logger.error("Could not get data source (HTTP #{resp.code}: #{resp.body})") if @debug
        return false
      end
    rescue => e
      @logger.error("Error getting existing data sources: #{e}") if @debug
      return false
    end
  end

  def update_data_source(id, ds={})
    @logger.info("Updating data source ID #{id}") if @debug

    existing_ds = self.get_data_source(id)
    ds = existing_ds.merge(ds)
    @logger.info(ds)

    begin
      resp = @api_instance["/api/datasources/#{id}"].put(
        ds.to_json,
        @headers
      )
      if resp.code.to_i == 200
        @logger.info("Data source successfully updated") if @debug
        return true
      else
        @logger.info("Data source could not be updated (HTTP #{resp.code}: #{resp.body})") if @debug
        return false
      end
    rescue => e
      @logger.error("Error updating data source: #{e}") if @debug
      return false
    end
  end

  def create_data_source(ds={})
    @logger.info("Creating data source: #{ds['name']} (database: #{ds['database']})") if @debug
    begin
      resp = @api_instance["/api/datasources"].post(
        ds.to_json,
        @headers
      )
      result = JSON.parse(resp.body)
      if resp.code.to_i == 200
        @logger.info("Data source ID #{result['id']} has been created") if @debug
        return true
      else
        @logger.error("Data source could not be created (HTTP #{resp.code}: #{resp.body})") if @debug
        return false
      end
    rescue => e
      @logger.error("Error creating data source: #{e}") if @debug
      return false
    end
  end

  def delete_data_source(id)
    @logger.info("Deleting data source #{id}") if @debug
    begin
      resp = @api_instance["/api/datasources/#{id}"].delete(@headers)
      result = JSON.parse(resp.body)
      if resp.code.to_i == 200
        @logger.info("Data source ID #{id} has been deleted") if @debug
        return true
      else
        @logger.error("Data source could not be deleted (HTTP #{resp.code}): #{resp.body}") if @debug
        return false
      end
    rescue => e
      @logger.error("Error creating data source: #{e}") if @debug
      return false
    end
  end



  def get_current_org()
    @logger.info("Getting current organization (GET /api/org)") if @debug
    begin
      resp = @api_instance['/api/org'].get(@headers)
      if resp.code.to_i == 200
        return JSON.parse(resp.body)
      else
        @logger.error("Could not get current organization: #{resp.body}") if @debug
        return false
      end
    rescue => e
     @logger.error("Could not get current organization: #{e}") if @debug
     return false
    end
  end

  def ping_session()
    @logger.info("Pingning current session (GET /api/login/ping)") if @debug
    begin
      resp = @api_instance['/api/login/ping'].get(@headers)
      if resp.code.to_i == 200
        return true
      else
        @logger.error("Could not ping session: #{resp.body}") if @debug
        return false
      end
    rescue => e
     @logger.error("Could not ping session: #{e}") if @debug
     return false
    end
  end

  def get_admin_settings()
    @logger.info("Getting admin settings (GET /api/admin/settings)") if @debug
    begin
      resp = @api_instance['/api/admin/settings'].get(@headers)
      if resp.code.to_i == 200
        return JSON.parse(resp.body)
      else
        @logger.error("Could not get admin settings: #{resp.body}") if @debug
        return false
      end
    rescue => e
     @logger.error("Could not get admin settings: #{e}") if @debug
     return false
    end
  end

end
