module Grafana

  module Frontend

    def get_frontend_settings()
      endpoint = "/api/frontend/settings"
      @logger.info("Getting frontend settings (GET #{endpoint})") if @debug
      return get_request(endpoint)
    end

  end

end
