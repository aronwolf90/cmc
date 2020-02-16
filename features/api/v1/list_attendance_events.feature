Feature: API: list attendance events

@javascript
Scenario: Get
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
 And I send a GET request to "/api/v1/attendance_events?page[number]=15-01-2019"
  Then the JSON response should be:
    """
    {
      "data": [
        {
          "id": "1",
          "type": "attendance-events",
          "attributes": { 
            "from-day": "2019-01-15",
            "to-day": "2019-01-16",
            "from-time": "09:00",
            "to-time": "18:00",
            "description": "Test description"
          },
          "relationships": {
            "user": {
              "data": {
                "id": "1",
                "type": "users"
              }
            }
          },
          "links": {
            "self": "/api/v1/attendance_events/1"
          },
          "meta": {
            "permissions": {
              "update": true, 
              "destroy": true
            }
          }
        }
      ],
      "links": {
        "first": null,
        "last": null,
        "prev": "2019-01-01",
        "next": "2019-01-29"
      }
    }
    """
  And the response status should be "200"
