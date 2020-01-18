Feature: API: get board list

Scenario: Get
  Given I am an user with an id of 1
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/users/1"
  Then the JSON response should be:
    """
    {
      "data": {
        "id": "1",
        "type": "users",
        "attributes": { 
          "firstname": null,
          "lastname": null,
          "email": "test@localhost.de",
          "type": "Admin",
          "active": true
        },
        "relationships": {
          "selected-project": {
            "data": null
          },
          "issues": { "data": [] },
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
