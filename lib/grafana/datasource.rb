
module Grafana

  module Datasource

    def get_cw_namespaces(datasource_id)
      endpoint = "/api/datasources/proxy/#{datasource_id}"
      @logger.info("Getting data source namespaces (POST /api/datasources/proxy/#{datasource_id})") if @debug
      return post_request(endpoint, {"action" => "__GetNamespaces"}.to_json)
    end

    def get_data_sources()
      endpoint = "/api/datasources"
      @logger.info("Attempting to get existing data sources (GET #{endpoint})") if @debug
      data_sources = get_request(endpoint)
      if !data_sources
        return false
      end
      data_source_map = {}
      data_sources.each { |ds|
        data_source_map[ds['id']] = ds
      }
      return data_source_map
    end 

    def get_data_source(id)
      endpoint = "/api/datasources/#{id}"
      @logger.info("Attempting to get existing data source ID #{id}") if @debug
      return get_request(endpoint)
    end

    def update_data_source(id, ds={})
      existing_ds = self.get_data_source(id)
      ds = existing_ds.merge(ds)
      endpoint = "/api/datasources/#{id}"
      @logger.info("Updating data source ID #{id}") if @debug
      return put_request(endpoint, ds.to_json)
    end

    def create_data_source(ds={})
      if ds == {} || !ds.has_key?('name') || !ds.has_key?('database')
        @logger.error("Error: missing 'name' and 'database' values!") if @debug
        return false
      end
      endpoint = "/api/datasources"
      @logger.info("Creating data source: #{ds['name']} (database: #{ds['database']})") if @debug
      return post_request(endpoint, ds.to_json)
    end

    def delete_data_source(id)
      endpoint = "/api/datasources/#{id}"
      @logger.info("Deleting data source #{id} (DELETE #{endpoint})") if @debug
      return delete_request(endpoint)
    end

    def get_available_data_source_types()
      endpoint = '/api/datasources/plugins'
      @logger.info("Attempting to get existing data source types (GET #{endpoint})") if @debug
      return get_request(endpoint)
    end

  end

end
