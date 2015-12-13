module Grafana

  module Login

    def ping_session()
      endpoint = "/api/login/ping"
      @logger.info("Pingning current session (GET #{endpoint})") if @debug
      return get_request(endpoint)

    end
  end

end
