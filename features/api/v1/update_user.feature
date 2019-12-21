Feature: API: create an user

  Scenario: Update an user
    Given The app contain seed data
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
            "email": "new@lvh.me"
          }
        }
      }
      """
    And the response status should be "204"
