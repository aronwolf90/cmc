Feature: API: create a project board list

@javascript
Scenario: Post an valid project board list using json in POST body
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a POST request to "/api/v1/project_board_lists" with the following:
    """
    {
      "data": {
        "attributes": {
          "name": "New"
        },
        "relationships": {
          "project-status": {
            "data": { "id": 1, "type": "project-statuses" }
          }
        }
      }
    }
    """
  Then the response status should be "201"
  And the JSON response should be:
    """
    {
      "data": {
        "id": "6",
        "type": "project-board-lists",
        "attributes": {
          "name": "New"
        },
        "relationships": {
          "projects": {"data": []},
          "project-status": {
            "data": {
              "id": "1",
              "type": "project-statuses"
            }
          }
        },
        "links": { "self": "/api/v1/project_board_lists/6" },
        "meta": {
          "permissions": {
            "update": true, 
            "destroy": true
          }
        }
      }
    }
    """
