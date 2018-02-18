Feature: API: update general board

Scenario: Put an valid general board using json in PUT body
  Given a board list exists with an id of 1
  And a board list exists with an id of 2
  And I am an user with an id of 1
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a PUT request to "/api/v1/general_board" with the following:
    """
    {
      "data": {
        "id": "general-board",
        "type": "general-boards",
        "relationships": {
          "board-lists": { "data": [
            { "id": "2", "type": "board-lists" },
            { "id": "1", "type": "board-lists" }
          ] }
        }
      }
    }
    """
  Then the response status should be "204"

Scenario: Put an invalid general board using json in PUT body
  And I am an user with an id of 1
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a PUT request to "/api/v1/general_board" with the following:
    """
    {
      "data": {
        "id": "general-board",
        "type": "general-boards",
        "relationships": {
          "board-lists": { "data": [
            { "id": null, "type": "board-lists" }
          ] }
        }
      }
    }
    """
  Then the response status should be "400"
