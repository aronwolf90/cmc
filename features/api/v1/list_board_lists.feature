Feature: API: list board lists

Scenario: Get
  Given I am an user with an id of 1
  And a board list exists with an id of 1
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/board_lists"
  Then the JSON response should be:
    """
    {
      "data": [{
        "id": "1",
        "type": "board-lists",
        "attributes": {
          "name": "name"
        },
        "relationships": {
          "issues": { "data": [] },
          "project": { "data": null }
        },
        "links": { "self": "/api/v1/board_lists/1" }
      }]
    }
    """
  And the response status should be "200"
