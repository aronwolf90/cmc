Feature: API: update general board

@javascript
Scenario: Put an valid board lists using json in PUT body
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a PUT request to "/api/v1/board_lists/7" with the following:
    """
    {
      "data": {
        "id": "7",
        "type": "board-lists",
        "attributes": {
          "name": "New name"
        }
      }
    }
    """
  Then the response status should be "204"
  When I send a GET request to "/api/v1/board_lists/7"
  Then the JSON response should be:
    """
    {
      "data": {
        "id": "7",
        "type": "board-lists",
        "attributes": { "name": "New name", "kind": "open" },
        "relationships": {
          "issues": {
            "data": [],
            "links": { "self": "/api/v1/board_lists/7/issues" }
          },
          "project": { "data": { "id": "2", "type": "projects" } }
        },
        "links": {
          "self": "/api/v1/board_lists/7"
        },
        "meta": {
          "permissions": {
            "update": true, 
            "destroy": false
          }
        }
      }
    }
    """
  And the response status should be "200"

@javascript
Scenario: Put an invalid board lists using json in PUT body
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a PUT request to "/api/v1/board_lists/1" with the following:
    """
    {
      "data": {
        "id": "1",
        "type": "board-lists",
        "relationships": {
          "issues": { "data": [
            { "id": null, "type": "board-lists" }
          ] }
        }
      }
    }
    """
  Then the response status should be "400"
