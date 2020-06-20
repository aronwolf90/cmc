Feature: API: get user_issue

@javascript
Scenario: Get
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/subscription"
  Then the response status should be "200"
  And the JSON response should be:
    """
    {
      "data": {
        "id": "subscription",
        "type": "subscriptions",
        "attributes": {
          "iban-last4": null,
          "premia": 0
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
