Feature: API: update project status

@javascript
Scenario: Put an valid record using json in PUT body
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a PATCH request to "/api/v1/project_statuses/1" with the following:
    """
    {
      "data": {
        "id": 1,
        "type": "project-statuses",
        "attributes": {
          "name": "New name"
        }

      }
    }
    """
  Then the response status should be "204"
