
module Grafana

  module DashboardTemplate

    # CloudWatch Namespaces, Dimensions and Metrics Reference:
    # http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/CW_Support_For_AWS.html
    @@cw_dimensions = []


    def build_template(params={})

      if !params.has_key?('from')
        params['from'] = 'now-2h'
      end
      if !params.has_key?('to')
        params['to'] = 'now'
      end
      if params['title'] == ''
        return false
      end

      rows = []
      params['panels'].each do |panel|
        rows.push(self.build_panel(panel))
      end
  
      tpl = %q[
      {
        "dashboard": { 
          "id": null,
          "title": "%{title}",
          "originalTitle": "%{title}",
          "annotations": {
            "list": []
          },
          "hideControls": false,
          "timezone": "browser",
          "editable": true,
          "rows": [
            %{rows}
          ],
          "time": {
            "from": "%{from}",
            "to": "%{to}"
          },
          "timepicker": {
            "collapse": false,
            "enable": true,
            "notice": false,
            "now": true,
            "refresh_intervals": [
              "5s",
              "10s",
              "30s",
              "1m",
              "5m",
              "15m",
              "30m",
              "1h",
              "2h",
              "1d"
            ],
            "status": "Stable",
            "time_options": [
              "5m",
              "15m",
              "1h",
              "6h",
              "12h",
              "24h",
              "2d",
              "7d",
              "30d"
            ],
            "type": "timepicker"
          },
          "tags": ["api-templated"],
          "templating": {
            "list": []
          },
          "schemaVersion": 7,
          "sharedCrosshair": false,
          "style": "dark",
          "version": 1,
          "links": []
        },
        "overwrite": false
      }
      ]

      return tpl % {
        title: params['title'], 
        from: params['from'], 
        to: params['to'], 
        rows: rows.join(',')
      }

    end


    def build_panel(params={})

      panel = %q[
        {
          "collapse": false,
          "editable": true,
          "height": "250px",
          "panels": [
            {
              "aliasColors": {},
              "bars": false,
              "datasource": "%{datasource}",
              "editable": true,
              "error": false,
              "fill": 1,
              "grid": {
                "leftLogBase": 1,
                "leftMax": null,
                "leftMin": null,
                "rightLogBase": 1,
                "rightMax": null,
                "rightMin": null,
                "threshold1": null,
                "threshold1Color": "rgba(216, 200, 27, 0.27)",
                "threshold2": null,
                "threshold2Color": "rgba(234, 112, 112, 0.22)"
              },
              "legend": {
                "avg": false,
                "current": false,
                "max": false,
                "min": false,
                "show": true,
                "total": false,
                "values": false
              },
              "lines": true,
              "linewidth": 2,
              "links": [],
              "nullPointMode": "connected",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "span": 12,
              "stack": false,
              "steppedLine": false,
              "targets": [
                %{targets}
              ],
              "timeFrom": null,
              "timeShift": null,
              "title": "%{graph_title}",
              "tooltip": {
                "shared": true,
                "value_type": "cumulative"
              },
              "type": "graph",
              "x-axis": true,
              "y-axis": true,
              "y_formats": [
                "short",
                "short"
              ]
            }
          ],
          "title": "Row"
        }
      ]

      targets = []
      params['targets'].each do |t|
        targets.push(self.build_target(t))
      end

  
      return panel % {
        datasource: params['datasource'],
        graph_title: params['graph_title'],
        targets: targets.join(',')
      }


    end


    def build_target(params={})

      target = %q[
        {
          "alias": "%{legend_alias}",
          "dimensions": {
            "%{dimension_name}": "%{dimension_value}"
          },
          "metricName": "%{metric_name}",
          "namespace": "%{namespace}",
          "period": 60,
          "query": "",
          "refId": "A",
          "region": "%{region}",
          "statistics": [
            "Maximum"
          ],
          "timeField": "@timestamp"
        }
      ]

      return target % {
        metric_name: params['metric_name'],
        namespace: params['namespace'],
        dimension_name: params['dimension_name'],
        dimension_value: params['dimension_value'],
        region: params['region'],
        legend_alias: params['legend_alias'],
      }

    end

  end

end

