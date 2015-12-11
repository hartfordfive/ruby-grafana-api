module Grafana

  module HttpRequest

    def get_request(endpoint)
      @logger.info("Running: Grafana::HttpRequest::#{__method__} on #{endpoint}") if @debug
      return _issue_request('GET', endpoint)
    end

    def post_request(endpoint, postdata={})
      @logger.info("Running: Grafana::HttpRequest::#{__method__} on #{endpoint}") if @debug
      return _issue_request('POST', endpoint, postdata)
    end

    def put_request(endpoint, putdata={})
      @logger.info("Running: Grafana::HttpRequest::#{__method__} on #{endpoint}") if @debug
      return _issue_request('PUT', endpoint, putdata)
    end

    def delete_request(endpoint)
      @logger.info("Running: Grafana::HttpRequest::#{__method__} on #{endpoint}") if @debug
      return _issue_request('DELETE', endpoint)
    end

    def patch_request(endpoint, patchdata={})
      @logger.info("Running: Grafana::HttpRequest::#{__method__} on #{endpoint}") if @debug
      return _issue_request('PATCH', endpoint, patchdata)
    end

    def _issue_request(method_type='GET', endpoint='/', data={})
  
      begin
        resp = nil
        case method_type.upcase
        when 'GET'
          resp = @api_instance[endpoint].get(@headers)
        when 'POST'
          resp = @api_instance[endpoint].patch(data,@headers)
        when 'PATCH'
          resp = @api_instance[endpoint].patch(data,@headers)
        when 'PUT'
          resp = @api_instance[endpoint].patch(data,@headers)
        when 'DELETE'
          resp = @api_instance[endpoint].patch(@headers)
        else
          @logger.error("Error: #{__method__} is not a valid request method.") if @debug
          return false
        end

        if (resp.code.to_i >= 200 && resp.code.to_i <= 299) || (resp.code.to_i >= 400 && resp.code.to_i <= 499)
          return JSON.parse(resp.body)
        else
          @logger.error("#{__method__} on #{endpoint} failed: HTTP #{resp.code} - #{resp.body}") if @debug
          return false
        end

      rescue => e
       @logger.error("Error: #{__method__} #{endpoint} error: #{e}") if @debug
       return false
      end

    end

  end

end
