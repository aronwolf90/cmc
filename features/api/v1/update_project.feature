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
        },
        "relationships": {
          "contact": {
            "data": {
              "id": "1",
              "type": "contacts"
            }
          }
        }
      }
    }
    """
  Then the response status should be "204"
  When I send a GET request to "/api/v1/projects/1"
  Then the JSON response should be:
    """
    {
      "data":{
        "id":"1",
        "type":"projects",
        "attributes":{
          "name":"New name",
          "description":"Test description"
        },
        "relationships":{
          "project-status":{
            "data":{
              "id":"1",
              "type":"project-statuses"
            }
          },
          "folder":{
            "data":{
              "id":"1",
              "type":"folders"
            }
          },
          "contact":{
            "data":{
              "id":"1",
              "type":"contacts"
            }
          },
          "main-responsable": {
            "data": null
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
    }
    """
