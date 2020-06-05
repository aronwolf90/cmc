Feature: API: get folder

@javascript
Scenario: Get
  And I send a GET request to "/api/v1/health_check"
  Then the response status should be "200"
