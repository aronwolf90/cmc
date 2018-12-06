Feature: API: update board list order

Scenario: valid data
  Given a board list exists with an id of 1
  And a board list exists with an id of 2
  And I am an user with an id of 1
  And I set headers:
    | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
    | Content-Type | application/vnd.api+json |
  When I send a PUT request to "/api/v1/board_lists/sort" with the following:
    """
      {
        "data": [2, 1]
      }
    """
  Then the response status should be "204"
  When I send a GET request to "/api/v1/board_lists"
  Then the JSON response should be:
    """
    {
      "data": [{
        "id": "2",
        "type": "board-lists",
        "attributes": { "name": "name" },
        "relationships": {
          "issues": {"data": []},
          "project": {"data": { "id": "2", "type": "projects" } }
        },
        "links": {"self": "/api/v1/board_lists/2"}
      }, {
        "id": "1",
        "type": "board-lists",
        "attributes": { "name": "name" },
        "relationships": {
          "issues": {"data": []},
          "project": {"data": { "id": "1", "type": "projects" } }
        },
        "links": {"self": "/api/v1/board_lists/1"}
      }]
    }
    """

Scenario: inalid data
  Given a board list exists with an id of 1
  And a board list exists with an id of 2
  And I am an user with an id of 1
  And I set headers:
    | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
    | Content-Type | application/vnd.api+json |
  When I send a PUT request to "/api/v1/board_lists/sort" with the following:
    """
    {
      "data": null
    }
    """
  Then the response status should be "400"
