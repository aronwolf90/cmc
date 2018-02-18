Feature: API: update general board

Scenario: Put an valid board lists using json in PUT body
  Given a board list exists with an id of 1
  And an issue exists with an id of 1
  And an issue exists with an id of 2
  And I am an user with an id of 1
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a PUT request to "/api/v1/board_lists/1" with the following:
    """
    {
      "data": {
        "id": "1",
        "type": "board-lists",
        "relationships": {
          "issues": { "data": [
            { "id": "2", "type": "issues" },
            { "id": "1", "type": "issues" }
          ] }
        }
      }
    }
    """
  Then the response status should be "204"

Scenario: Put an invalid board lists using json in PUT body
  Given a board list exists with an id of 1
  And I am an user with an id of 1
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
