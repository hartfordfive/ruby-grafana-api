
module Grafana

  module Dashboard

    def create_slug(text)
      if text =~ /\s/
        if text =~ /-/
          text = text.gsub(/\s+/, "").downcase
        else
          text = text.gsub(/\s+/, "-").downcase
        end
      end
      return text
    end

    def get_cw_namespaces(datasource_id)
      @logger.info("Getting data source namespaces (POST /api/datasources/proxy/#{datasource_id})") if @debug
      begin
        resp = @api_instance["/api/datasources/proxy/#{datasource_id}"].post(
          {"action" => "__GetNamespaces"}.to_json,
          @headers
        )
        if resp.code.to_i == 200
          @logger.info("Got data source namespaces") if @debug
          return JSON.parse(resp.body)
        else
          @logger.error("Could not get data source namespaces (HTTP #{resp.code}: #{resp.body})") if @debug
          return false
        end
      rescue => e
        @logger.error("Error getting data source namespaces: #{e}") if @debug
        return false
      end
    end

    def get_dashboard(name='')

      name = self.create_slug(name)

      begin 
        @logger.info("Attempting to get dashboard (GET /api/dashboards/db/#{name})") if @debug
        resp = @api_instance["/api/dashboards/db/#{name}"].get(@headers)

        if resp.code.to_i == 200
          return JSON.parse(resp.body)
        else
          @logger.error("Could not retreive dashboard (HTTP #{resp.code}: #{resp.body})") if @debug
          return false
        end
      rescue => e
        @logger.error("Error getting dashboard: #{e}") if @debug
        return false
      end
    end 

    def create_dashboard(properties={})

      @logger.info("Creating dashboard: #{properties['title']} (POST /api/dashboards/db)") if @debug
      begin
        dashboard = self.build_template(properties)
        File.open('dashboard.json', 'w') { |file| file.write(dashboard) }
        resp = @api_instance["/api/dashboards/db"].post(
          dashboard,
          @headers
        )
        if resp.code.to_i == 200
          @logger.info("Dashboard has been created: #{resp.body}") if @debug
          return true
        else
          @logger.error("Dashboard could not be created (HTTP #{resp.code}: #{resp.body})") if @debug
          return false
        end
      rescue => e
        @logger.error("Error creating dashboard: #{e}") if @debug
        return false
      end
    end

    def delete_dashboard(name)
      name = self.create_slug(name)
      endpoint = "/api/dashboards/db/#{name}"
      @logger.info("Deleting dahsboard ID #{id} (DELETE #{endpoint})") if @debug
      begin
        resp = @api_instance[endpoint].delete(@headers)
        if resp.code.to_i == 200
          @logger.info("Dashboard ID #{id} has been deleted") if @debug
          return true
        else
          @logger.error("Could note delete dashboard: #{resp.body}") if @debug
          return false
        end
      rescue => e
       @logger.error("Could not delete dashboard: #{e}") if @debug
       return false
      end
    end

    def get_home_dashboard()
      endpoint = "/api/dashboards/home"
      begin 
        @logger.info("Attempting to get home dashboard (GET #{endpoint})") if @debug
        resp = @api_instance[endpoint].get(@headers)

        if resp.code.to_i == 200
          return JSON.parse(resp.body)
        else
          @logger.error("Could not retreive home dashboard (HTTP #{resp.code}: #{resp.body})") if @debug
          return false
        end
      rescue => e
        @logger.error("Error getting home dashboard: #{e}") if @debug
        return false
      end
    end


    def get_dashboard_tags()
      endpoint = "/api/dashboards/tags"
      begin 
        @logger.info("Attempting to get dashboard tags(GET #{endpoint})") if @debug
        resp = @api_instance[endpoint].get(@headers)

        if resp.code.to_i == 200
          return JSON.parse(resp.body)
        else
          @logger.error("Could not retreive dashboard tags (HTTP #{resp.code}: #{resp.body})") if @debug
          return false
        end
      rescue => e
        @logger.error("Error getting dashboard tags: #{e}") if @debug
        return false
      end
    end

    def search_dashboards(params={})

      params['query'] = (params['query'].length >= 1 ? CGI::escape(params['query']) : '' )
      params['starred'] = (params['starred'] ? 'true' : 'false')

      endpoint = "/api/search/?query=#{params['query']}&starred=#{params['starred']}&tag=#{params['tags']}"
      begin 
        @logger.info("Attempting to search for dashboards (GET #{endpoint})") if @debug
        resp = @api_instance[endpoint].get(@headers)

        if resp.code.to_i == 200
          return JSON.parse(resp.body)
        else
          @logger.error("Could not search for dashboard (HTTP #{resp.code}: #{resp.body})") if @debug
          return false
        end
      rescue => e
        @logger.error("Error search for dashboard: #{e}") if @debug
        return false
      end
    end

  end

end
