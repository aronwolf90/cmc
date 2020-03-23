Feature: API: update project board lists

@javascript
Scenario: PATCH with valid data a project board lists
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a PATCH request to "/api/v1/project_board_lists/1" with the following:
    """
    {
      "data": {
        "id": "1",
        "type": "project-board-lists",
        "attributes": {
          "name": "Test",
          "ordinal-number": 1
        }
      }
    }
    """
  Then the response status should be "204"
