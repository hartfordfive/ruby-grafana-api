
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

    def get_dashboard(name='')
      name = self.create_slug(name)
      endpoint = "/api/dashboards/db/#{name}"
      @logger.info("Attempting to get dashboard (GET /api/dashboards/db/#{name})") if @debug
      return get_request(endpoint)
    end

    def create_dashboard(properties={})
      endpoint = "/api/dashboards/db"
      dashboard = self.build_template(properties)
      @logger.info("Creating dashboard: #{properties['title']} (POST /api/dashboards/db)") if @debug
      return post_request(endpoint, dashboard)
    end

    def delete_dashboard(name)
      name = self.create_slug(name)
      data = self.get_dashboard( name )
      id   = data['dashboard']['id'] ? data['dashboard']['id'] : nil

      endpoint = "/api/dashboards/db/#{name}"
      @logger.info("Deleting dahsboard ID #{id} (DELETE #{endpoint})") if @debug
      return delete_request(endpoint)
    end

    def get_home_dashboard()
      endpoint = "/api/dashboards/home"
      @logger.info("Attempting to get home dashboard (GET #{endpoint})") if @debug
      return get_request(endpoint)
    end
    
    def get_dashboard_tags()
      endpoint = "/api/dashboards/tags"
      @logger.info("Attempting to get dashboard tags(GET #{endpoint})") if @debug
      return get_request(endpoint)
    end

    def search_dashboards(params={})
      params['query'] = (params['query'].length >= 1 ? CGI::escape(params['query']) : '' )
      params['starred'] = (params['starred'] ? 'true' : 'false')
      endpoint = "/api/search/?query=#{params['query']}&starred=#{params['starred']}&tag=#{params['tags']}"
      @logger.info("Attempting to search for dashboards (GET #{endpoint})") if @debug
      return get_request(endpoint)
    end

  end

end
