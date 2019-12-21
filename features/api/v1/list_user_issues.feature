Feature: API: list user issues

Scenario: Get
  Given I am an user with an id of 1
  And a project exists with an id of "1"
  And the following board list exist:
   | id | project_id |
   | 1  | 1          |
  And the following issue exist:
   | id | board_list_id |
   | 1  | 1             |
  And the following record exist:
   | id | user_id | issue_id |
   | 1  | 1       | 1        |
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
          "start-time": "2018-01-29T20:09:37.000+01:00"
        },
        "relationships": {
          "user": { "data": { "id": "1", "type": "users"  } },
          "issue": { "data": { "id": "1", "type": "issues"  } }
        }
      }],
      "links": { "self": "/api/v1/user_issues" }
    }
    """
  And the response status should be "200"
