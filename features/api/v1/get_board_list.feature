Feature: API: get board list

Scenario: Get
  Given a board list exists with an id of 1
  And I am an user with an id of 1
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/board_lists/1"
  Then the JSON response should be:
    """
    {
      "data": {
        "id": "1",
        "type": "board-lists",
        "attributes": {
          "name": "name"
        },
        "relationships": {
          "issues": { "data": [] },
          "project": { "data": { "id": "1", "type": "projects" } }
        },
        "links": { "self": "/api/v1/board_lists/1" }
      }
    }
    """
  And the response status should be "200"
