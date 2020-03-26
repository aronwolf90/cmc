Feature: API: create a project comment

@javascript
Scenario: Post an valid project comment using json in POST body
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a POST request to "/api/v1/project_comments" with the following:
    """
    {
      "data": {
        "attributes": { "content": "comment" },
        "relationships": {
          "user": { "data": { "id": "1", "type": "users" } },
          "project": { "data": { "id": "1", "type": "projects" } }
        }
      }
    }
    """
  Then the response status should be "201"
  And the JSON response should be:
    """
    {
      "data": {
        "id": "2",
        "type": "project-comments",
        "attributes": { "content": "comment" },
        "relationships": {
          "user": { "data": { "id": "1", "type": "users" } },
          "project": { "data": { "id": "1", "type": "projects" } }
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
