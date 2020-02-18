Feature: API: create an comment

@javascript
Scenario: Post an valid comment using json in POST body
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
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
        },
        "meta": {
          "permissions": {
            "update": true, 
            "destroy": true
          }
        }
      }
    }
    """
  And the response status should be "201"

  @javascript
  Scenario: Post an invalid comment using json in POST body
    Given a test-organization exists and is loaded
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
