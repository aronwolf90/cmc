Feature: API: get context

Scenario: Get
  And I am an user with an id of 1
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/context"
  Then the JSON response should be:
    """
    {
      "data": {
        "id": "context",
        "type": "contexts",
        "relationships": {
          "current-user": { "data": { "id": "1", "type": "users" } }
        }
      },
      "included": [{
        "id": "1",
        "type": "users",
        "attributes": { "firstname": null },
        "relationships": { "issues": { "data": [] }, "current-record": { "data": null } }
      }]
    }
    """
  And the response status should be "200"