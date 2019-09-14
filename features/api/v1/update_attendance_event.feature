Feature: API: update an attendance event

Scenario: Post an valid event using json in POST body
  Given I am an user with an id of 1
  And the following attendance event exist:
   | id | user_id |
   | 1  | 1       |
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a PUT request to "/api/v1/attendance_events/1" with the following:
    """
    {
      "data": {
        "attributes": {
          "from-day": "1.1.2019", 
          "to-day": "1.1.2019",
          "from-time": "09:00",
          "to-time": "18:00",
          "description": "test description"
        },
        "relationships": {
          "user": {
            "data": {
              "id": "1",
              "type": "admin"
            }
          }
        }
      }
    }
    """
  Then the response status should be "204"
