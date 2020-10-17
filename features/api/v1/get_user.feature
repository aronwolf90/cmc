Feature: API: get board list

@javascript
Scenario: Get
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/users/1"
  Then the JSON response should match:
    """
    {
      "data": {
        "id": "1",
        "type": "users",
        "attributes": { 
          "firstname": "Aron",
          "lastname": "Wolf",
          "email": "admin@lvh.me",
          "type": "Admin",
          "active": true,
          "records-count": 4,
          "avatar-url": "/packs/images/avatar_placeholder<.+>" 
        },
        "relationships": {
          "selected-project": {
            "data": { "id": "1", "type": "projects" }
          },
          "issues": {
            "data": [
              {"id": "1", "type": "issues"},
              {"id": "2", "type": "issues"}
            ]
          },
          "current-record": { "data": null }
        },
        "links": {"self": "/api/v1/users/1"},
        "meta": {
          "permissions": {
            "update": true,
            "destroy": true
          }
        }
      }
    }
    """
  And the response status should be "200"
