Feature: API: list users

Scenario: Get
  Given an issue exists with an id of 1
  And I am an user with an id of 1
  And An record for user "1" and issue "1"
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/user_issues"
  Then the JSON response should be:
    """
    {
      "data": [{
        "id": "1,1",
        "type": "user-issues",
        "attributes": { 
          "spent-time": 60, 
          "start-time": "2018-06-11T16:58:00.049+02:00"
        },
        "relationships": {
          "user": { "data": { "id": "1", "type": "admins"  } },
          "issue": { "data": { "id": "1", "type": "issues"  } }
        }
      }]
    }
    """
  And the response status should be "200"
