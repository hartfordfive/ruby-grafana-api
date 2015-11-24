
module Grafana

  module Datasource

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

  end

end
