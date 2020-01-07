Feature: API: get user_issue

Scenario: Get
  Given The app contain seed data
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
          "iban-last4": "4242",
          "premia": 0
        }
      }
    }
    """
