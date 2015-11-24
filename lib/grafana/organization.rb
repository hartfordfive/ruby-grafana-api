
module Grafana

  module Organization

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

  end

end
