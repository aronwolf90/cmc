Feature: API: Destroy google calender integration

@javascript
Scenario: Destroy an attendance event
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a DELETE request to "/api/v1/calenders/google_integration"
  Then the response status should be "200"
