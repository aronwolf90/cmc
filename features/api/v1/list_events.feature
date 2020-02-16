Feature: API: list issues

@javascript
Scenario: Get /api/v1/events
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/events"
  Then the JSON response should be:
    """
    {
      "data": [{
        "id": "1",
        "type": "events",
        "attributes": { 
          "title": "Test event",
          "start-time": "2018-10-20T17:15:06.000+02:00",
          "end-time": null,
          "all-day": true,
          "description": null
        },
        "links": {
          "self": "/api/v1/events/1"
        },
        "meta": {
          "permissions": {
            "update": true,
            "destroy": true
          }
        }
      }],
      "links": { "self": "/api/v1/events" }
    }
    """
  And the response status should be "200"
