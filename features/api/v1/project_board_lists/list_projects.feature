Feature: API: List board_lists issues

@javascript
Scenario: GET /api/v1/board_lists/<id>/issues
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a GET request to "/api/v1/project_board_lists/1/projects"
  Then the response status should be "200"
  And the JSON response should be:
    """
    { 
      "data":[ 
        { 
          "id":"1",
          "type":"projects",
          "attributes":{ 
            "name":"Test project",
            "description": "Test description"
          },
          "relationships": {
            "project-status": {
              "data": {"id": "1", "type": "project-statuses" }
            },
            "folder": {
              "data": {
                "id": "1",
                "type": "folders"
              }
            },
            "contact": {
              "data": {
                "id": "2",
                "type": "contacts"
              }
            }
          },
          "links":{ 
            "self":"/api/v1/projects/1"
          },
          "meta":{ 
            "permissions":{ 
              "update":true,
              "destroy":true
            }
          }
        }
      ],
		  "links": { "next": null }
    }
    """
