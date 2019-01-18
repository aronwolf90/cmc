Feature: API: list users

Scenario: Get
  Given I am an user with an id of 1
  And a folder with an id of 1 exists
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
          "name": "folder name",
          "root": true
        },
        "relationships": {
          "folder": { "data": null },
          "folders": { "data": [] },
          "documents": { "data": [] }
        }
      }],
      "links": { "self": "/api/v1/folders" }
    }
    """
  And the response status should be "200"
