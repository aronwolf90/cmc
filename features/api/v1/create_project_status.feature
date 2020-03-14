Feature: API: create an record

@javascript
Scenario: Post an valid record using json in POST body
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a POST request to "/api/v1/project_statuses" with the following:
    """
    {
      "data": {
        "attributes": {
          "name": "New"
        }
      }
    }
    """
  Then the response status should be "201"
  And the JSON response should be:
    """
    {
      "data": {
        "id": "4",
        "type": "project-statuses",
        "attributes": {
          "name": "New",
          "initial": false
        },
        "relationships": {
          "projects": {"data": []}
        },
        "links": { "self": "/api/v1/project_statuses/4" },
        "meta": {
          "permissions": {
            "update": true, 
            "destroy": true
          }
        }
      }
    }
    """
