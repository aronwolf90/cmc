Feature: API: create a project

@javascript
Scenario: Post an valid record using json in POST body
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a POST request to "/api/v1/projects" with the following:
    """
    {
      "data": {
        "attributes": {
          "name": "New",
          "description": "Description"
        },
        "relationships": {
          "contact": {
            "data": {
              "attributes": {
                "name": "Test name",
                "description": "Test name"
              }
            }
          },
          "project-status": {
            "data": { "id": 1, "type": "projects" }
          },
          "main-responsable": {
            "data": {
              "id": "1",
              "type": "users"
            }
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
        "id": "3",
        "type": "projects",
        "attributes": {
          "name": "New",
          "description": "Description"
        },
        "relationships": {
          "project-status": {
            "data": { "id": "1", "type": "project-statuses" }
          },
          "folder": {
            "data": {
              "id": "5",
              "type": "folders"
              },
              "links": {
                "self": "/api/v1/folders/5"
              }
          },
          "contact": {
            "data": {
              "id": "3",
              "type": "contacts"
            }
          },
          "main-responsable": {
            "data": {
              "id": "1",
              "type": "users"
            }
          }
        },
        "links": { "self": "/api/v1/projects/3" },
        "meta": {
          "permissions": {
            "update": true, 
            "destroy": true
          }
        }
      }
    }
    """
