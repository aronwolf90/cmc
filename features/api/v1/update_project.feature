Feature: API: update a project

@javascript
Scenario: PATCH
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a PATCH request to "/api/v1/projects/1" with the following:
    """
    {
    "data": {
        "id": 1,
        "type": "projects",
        "attributes": {
          "name": "New name"
        }
      }
    }
    """
  Then the response status should be "204"
