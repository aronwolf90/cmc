Feature: API: get user_issue

Scenario: Get
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/user_issues/1,1"
  Then the JSON response should be:
    """
    {
      "data": {
        "id": "1,1",
        "type": "user-issues",
        "attributes": { 
          "spent-time": 0, 
          "start-time": null
        },
        "relationships": {
          "user": { "data": { "id": "1", "type": "users" } },
          "issue": { "data": { "id": "1", "type": "issues"  } }
        }
      }
    }
    """
  And the response status should be "200"
