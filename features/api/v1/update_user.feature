Feature: API: create an user

  @javascript
  Scenario: Update an user
    Given a test-organization exists and is loaded
    And I set headers:
     | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
     | Content-Type | application/vnd.api+json |
    When I send a PUT request to "/api/v1/users/2" with the following:
      """
      {
        "data": {
          "id": "2",
          "type": "users",
          "attributes": { 
            "firstname": "New firstname",
            "lastname": "New lastname",
            "type": "Customer",
            "email": "new@lvh.me",
            "telephone-number": "01687696879"
          }
        }
      }
      """
    Then the response status should be "204"
    When I send a GET request to "/api/v1/users/2"
    Then the response status should be "200"
    And the JSON response should be:
      """
      {
        "data": {
          "id": "2",
          "type": "users",
          "attributes": {
            "firstname": "New firstname",
            "lastname": "New lastname",
            "email": "new@lvh.me",
            "type": "Employee",
            "active": true,
            "records-count": 2,
            "avatar-url": "/api/v1/user_avatars/placeholder",
						"telephone-number": "01687696879"
          },
          "relationships": {
            "selected-project": {
              "data": {
                "id": "1",
                "type": "projects"
              }
            },
            "issues": {
              "data": [

              ]
            },
            "current-record": {
              "data": null
            }
          },
          "links": {
            "self": "/api/v1/users/2"
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
