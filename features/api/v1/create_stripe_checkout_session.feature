Feature: API: create a stripe checkout session

@javascript
Scenario: Valid post '/api/v1/stripe_checkout_session'
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a POST request to "/api/v1/stripe_checkout_sessions" with the following:
    """
    {}
    """
  Then the JSON response should match:
    """
    {
      "data": {
        "id": "cs_test_<.*>",
        "type": "stripe-checkout-sessions"
      }
    }
    """
  And the response status should be "201"
