Feature: API: create an user

  Scenario: Create an user
    Given The app contain seed data
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
    Then the JSON response should be:
      """
      {
        "data": {
          "id": "4",
          "type": "users",
          "attributes": { 
            "firstname": "Lara",
            "lastname": "Croft",
            "email": "test@lvh.me"
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
    And the response status should be "201"
