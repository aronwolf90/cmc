Feature: API: create an user

  @javascript
  Scenario: Create an user
    Given a test-organization exists and is loaded
    And I set headers:
     | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
     | Content-Type | application/vnd.api+json |
    When I send a POST request to "/api/v1/users" with the following:
      """
      {
        "data": {
          "attributes": { 
            "firstname": "Lara",
            "lastname": "Croft",
            "type": "Admin",
            "email": "test@lvh.me"
          }
        }
      }
      """
    Then the response status should be "201"
    And the JSON response should match:
      """
      {
        "data": {
          "id": "4",
          "type": "users",
          "attributes": { 
            "firstname": "Lara",
            "lastname": "Croft",
            "email": "test@lvh.me",
            "type": "Admin",
            "active": true,
            "records-count": 0,
            "avatar-url": "/packs/images/avatar_placeholder<.+>"  
          },
          "relationships": {
            "selected-project": {
              "data": {
                "id": "1",
                "type": "projects"
              }
            },
            "issues": { "data": [] },
            "current-record": { "data": null }
          },
          "links": {"self": "/api/v1/users/4"},
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          }
        }
      }
      """
