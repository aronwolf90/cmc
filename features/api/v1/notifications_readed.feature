Feature: API: create an user

  @javascript
  Scenario: Valid request
    Given a test-organization exists and is loaded
    And I set headers:
     | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
     | Content-Type | application/vnd.api+json |
    When I send a POST request to "/api/v1/notifications_readed" with the following:
      """
      {
        "data": {
          "attributes": { 
            "readed-at": "17-08-2019 17:00:00"
          }
        }
      }
      """
    And the response status should be "200"
