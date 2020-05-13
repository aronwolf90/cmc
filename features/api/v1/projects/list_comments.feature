Feature: API: List project comments

@javascript
Scenario: GET /api/v1/projects/<id>/project_comments
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a GET request to "/api/v1/projects/1/project_comments"
  Then the response status should be "200"
  And the JSON response should be:
    """
    { 
      "meta": {
        "count": 1
      },
      "data":[ 
        { 
          "id":"1",
          "type":"project-comments",
          "attributes":{ 
            "content":"Test content"
          },
          "relationships": {
            "project": {
              "data": {"id": "1", "type": "projects" }
            },
            "user": {
              "data": {"id": "1", "type": "users" }
            }
          },
          "meta":{ 
            "permissions":{ 
              "update":true,
              "destroy":true
            }
          }
        }
      ],
      "links":{ 
        "self":"/api/v1/projects/1/project_comments"
      }
    }
    """
