Feature: API: list users

@javascript
Scenario: Get
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/folders"
  Then the JSON response should be:
    """
    {
      "data": [{
        "id": "1",
        "type": "folders",
        "attributes": {
          "name": "folder 1",
          "root": true
        },
        "relationships": {
          "folder": { "data": null },
          "folders": { "data": [] },
          "documents": { "data": [{ "id": "1", "type": "documents" }] }
        },
        "meta": {
          "permissions": {
            "update": true,
            "destroy": true
          }
        }
      }],
      "links": { "self": "/api/v1/folders" }
    }
    """
  And the response status should be "200"
