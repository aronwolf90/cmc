Feature: API: destroy an event

@javascript
Scenario: Destroy a document
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a DELETE request to "/api/v1/documents/1"
  Then the response status should be "200"
  When I send a GET request to "/api/v1/documents/1"
  Then the response status should be "404"
