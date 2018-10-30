Feature: API: create an comment

Scenario: Post an valid event using json in POST body
  Given I am an user with an id of 1
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a POST request to "/api/v1/events" with the following:
    """
    {
      "data": {
        "attributes": {
          "title": "Title",
          "all-day": "comment", 
          "start-time": "1.1.2019",
          "description": "description"
        }
      }
    }
    """
  Then the JSON response should be:
    """
    {
      "data": {
        "id": "1",
        "type": "events",
        "attributes": { 
          "title": "Title",
          "start-time": "2019-01-01T00:00:00.000+01:00",
          "end-time": null,
          "all-day": true,
          "description": "description"
        },
        "links": { "self": "/api/v1/events/1" }
      }
    }
    """
  And the response status should be "201"

  Scenario: Post an invalid event using json in POST body
    Given I am an user with an id of 1
    And I set headers:
     | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
     | Content-Type | application/vnd.api+json |
    When I send a POST request to "/api/v1/events" with the following:
    """
    {
      "data": {
        "attributes": { 
          "all-day": "comment" 
        }
      }
    }
    """
    Then the response status should be "400"
