Feature: API: create an comment

Scenario: Post an valid comment using json in POST body
  Given I am an user with an id of 1
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And an issue exists with an id of 1
  When I send a POST request to "/api/v1/comments" with the following:
    """
    {
      "data": {
        "attributes": { "content": "comment" },
        "relationships": {
          "user": { "data": { "id": "1", "type": "users" } },
          "issue": { "data": { "id": "1", "type": "issues" } }
        }
      }
    }
    """
  Then the JSON response should be:
    """
    {
      "data": {
        "id": "1",
        "type": "comments",
        "attributes": { "content": "comment" },
        "relationships": {
          "issue": { "data": { "id": "1", "type": "issues" } },
          "user": { "data": { "id": "1", "type": "users" } }
        }
      }
    }
    """
  And the response status should be "201"

  Scenario: Post an invalid comment using json in POST body
    Given I am an user with an id of 1
    And an issue exists with an id of 1
    And I set headers:
     | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
     | Content-Type | application/vnd.api+json |
    When I send a POST request to "/api/v1/comments" with the following:
    """
    {
      "data": {
        "id": "1",
        "type": "comments",
        "attributes": { "content": "comment" },
        "relationships": {
          "user": { "data": { "id": 1, "type": "users" } }
        }
      }
    }
    """
    Then the response status should be "400"
