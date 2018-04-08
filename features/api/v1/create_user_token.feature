Feature: API: create user token

Scenario: Post valid authentication data
  Given I am an user with an email "test@localhost.de" and a password "testtest" and and id of "1"
  And I set headers:
   | Content-Type | application/json |
  When I send a POST request to "/api/v1/user_tokens" with the following:
    """
    { "auth": { "email": "test@localhost.de", "password": "testtest" } }
    """
  Then the JSON response should be:
    """
    { "jwt": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU" }
    """
  And the response status should be "201"
