Feature: API: is secure

@javascript
Scenario: Can not access api without key
  Given a test-organization exists and is loaded
  And I send a GET request to "/api/v1/users"
  And I set headers:
  | Content-Type | application/vnd.api+json |
  Then the response status should be "302"

@javascript
Scenario: Can not access api wit an invalid key
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer invalid |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/users"
  Then the response status should be "401"

@javascript
Scenario: Can not access api wit an invalid key
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/users"
  Then the response status should be "200"
