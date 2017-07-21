
## Grafana API CHANGELOG

Version 0.2.0
----------
- Fixed parenthesis issue in Dashboard module (nicolasbrechet, Issue #18)
- Added functionality to fetch grafana dashboard list (shukla-praveen, Issue #16)
- Fixed current user log when debugging on (sebastienluquet, Issue #15)
- Enable an API Request, when grafana is located behind a proxy or the uri_path has changed (bodsch, Issue #12)
- Add APIkey auth capability using headers (BarthV, Issue #11)

Version 0.1.2
----------
* Fixed issue in http_request wrapper where patch method was being used where it should have been the correct POST/PUT/DELETE methods

Version 0.1.0
----------
* Implemented the rest of the HTTP API methods and updated documentation


Version 0.0.1
----------
* Initial version with very limitted set of methods implemented
