Feature: API: create board list

@javascript
Scenario: Post an valid event using json in POST body
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a POST request to "/api/v1/board_lists" with the following:
    """
    {
      "data": {
        "attributes": {
          "name": "Test name"
        }
      }
    }
    """
  Then the JSON response should be:
    """
    {
      "data": {
        "id": "10",
        "type": "board-lists",
        "attributes": { 
          "name": "Test name",
          "kind": null
        },
        "relationships": {
          "issues": {
            "data": [],
            "links": { "self": "/api/v1/board_lists/10/issues" }
          },
          "project": {
            "data": null
          }
        },
        "meta": {
          "permissions": {
            "update": true, 
            "destroy": true
          }
        },
        "links": { "self": "/api/v1/board_lists/10" }
      }
    }
    """
  And the response status should be "201"
