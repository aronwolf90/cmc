Feature: API: post /api/v1/folders

@javascript
Scenario: Create a folder
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a POST request to "/api/v1/folders" with the following:
    """
    {
      "data": {
        "attributes": { 
          "name": "Test"
        },
        "relationships": {
          "folder": {
            "data": {
              "id": 1,
              "type": "folders"
            }
          }
        }
      }
    }
    """
  Then the JSON response should match:
    """
    {
      "data": {
        "id": "<.*>",
        "type": "folders",
        "attributes": { 
          "name": "Test",
          "root": false
        },
        "relationships": {
          "folder": {
            "data": {
              "id": "1",
              "type": "folders"
            }
          },
          "folders": {
            "data": []
          },
          "documents": {
            "data": []
          }
        },
        "links": {
          "self": "/api/v1/folders/<.*>"
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
  And the response status should be "201"
