Feature: API: get folder

@javascript
Scenario: Get
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/folders/3"
  Then the response status should be "200"
  And the JSON response should be:
    """
    {
      "data": {
        "id": "3",
        "type": "folders",
        "attributes": {
          "name": "folder 1",
          "root": true
        },
        "relationships": {
          "folder": {
            "data": null
          },
          "folders": {
            "data": [
              {"id": "4", "type": "folders"}
            ]
          },
          "documents": {
            "data": [
              {"id": "3", "type": "documents"}
            ]
          }
        },
        "meta": {
          "permissions": {
            "update": true, 
            "destroy": true
          }
        },
        "links": {
          "self": "/api/v1/folders/3"
        }
      }
    }
    """
