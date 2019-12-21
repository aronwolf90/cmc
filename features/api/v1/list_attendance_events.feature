Feature: API: list attendance events

Scenario: Get
  Given I am an user with an id of 1
  And the following attendance event exist:
   | id | user_id | from_day     | to_day       | from_time | to_time |
   | 1  | 1       | "2019-01-15" | "2019-01-16" | "09:00"   |"18:00"  |
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
            "description": null
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
