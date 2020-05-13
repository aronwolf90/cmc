Feature: API: get project status

@javascript
Scenario: Get
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/project_statuses/1"
  Then the response status should be "200"
  And the JSON response should be:
    """
    {
      "data": {
        "id": "1",
        "type": "project-statuses",
        "attributes": {
          "name": "New",
          "display-as": "board",
          "initial": true
        },
        "relationships": {
          "projects": {
            "data": [
              {
                "id": "1",
                "type": "projects"
              },
              {
                "id": "2",
                "type": "projects"
              },
              {
                "id": "3",
                "type": "projects"
              },
              {
                "id": "4",
                "type": "projects"
              },
              {
                "id": "5",
                "type": "projects"
              },
              {
                "id": "6",
                "type": "projects"
              },
              {
                "id": "7",
                "type": "projects"
              },
              {
                "id": "8",
                "type": "projects"
              },
              {
                "id": "9",
                "type": "projects"
              },
              {
                "id": "10",
                "type": "projects"
              },
              {
                "id": "11",
                "type": "projects"
              },
              {
                "id": "12",
                "type": "projects"
              },
              {
                "id": "13",
                "type": "projects"
              },
              {
                "id": "14",
                "type": "projects"
              },
              {
                "id": "15",
                "type": "projects"
              },
              {
                "id": "16",
                "type": "projects"
              },
              {
                "id": "17",
                "type": "projects"
              }
            ]
          },
          "project-board-lists": {
            "data": [
              {"id": "1", "type": "project-board-lists"},
              {"id": "2", "type": "project-board-lists"},
              {"id": "3", "type": "project-board-lists"}
            ]
          }
        },
        "links": {
          "self": "/api/v1/project_statuses/1"
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
