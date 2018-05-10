Feature: API: update an user

Scenario: Put an valid record using json in PUT body
  Given I am an user with an id of 1
  And an project with an id of 1 exists
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a PATCH request to "/api/v1/users/1" with the following:
    """
    {
      "data": {
        "id": 1,
        "type": "users",
        "relationships": {
          "selected-project": { "data": { "id": 1, "type": "projects" } }
        }
      }
    }
    """
  Then the response status should be "204"

Scenario: Put an invalid record using json in PUT body
  Given I am an user with an id of 1
  And an project with an id of 1 exists
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a PATCH request to "/api/v1/users/1" with the following:
    """
    {
      "data": {
        "id": 1,
        "type": "users",
        "relationships": {
          "selected-project": { "data": { "id": 0, "type": "projects" } }
        }
      }
    }
    """
  Then the response status should be "400"
