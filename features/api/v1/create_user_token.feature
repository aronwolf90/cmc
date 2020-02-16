Feature: API: create user token

@javascript
Scenario: Post valid authentication data
  Given a test-organization exists and is loaded
  And I set headers:
   | Content-Type | application/json |
  When I send a POST request to "/api/v1/user_tokens" with the following:
    """
    { "auth": { "email": "admin@lvh.me", "password": "testtest" } }
    """
  And the response status should be "201"
