Feature: API: list issues

Scenario: Get /api/v1/events
  Given an event exists with an id of 1
  And I am an user with an id of 1
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
          "title": "Test",
          "start-time": null,
          "end-time": null,
          "all-day": true,
          "description": null
        },
        "links": { "self": "/api/v1/events/1" }
      }]
    }
    """
  And the response status should be "200"
