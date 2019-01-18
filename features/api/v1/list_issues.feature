Feature: API: list issues

Scenario: Get /api/v1/issues
  Given an issue exists with an id of 1
  And I am an user with an id of 1
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/issues"
  Then the JSON response should be:
    """
    {
      "links": {
        "self": "/api/v1/issues?page%5Bnumber%5D=1&page%5Bsize%5D=15",
        "first": "/api/v1/issues?page%5Bnumber%5D=1&page%5Bsize%5D=15",
        "prev": null, 
        "next": null, 
        "last": "/api/v1/issues?page%5Bnumber%5D=1&page%5Bsize%5D=15"
      },
      "data": [{
        "id": "1",
        "type": "issues",
        "attributes": { 
          "title": "title",
          "description": null,
          "complexity": null
        },
        "relationships": {
          "user": { "data": null },
          "board-list": { 
            "data": { 
              "id": "10",
              "type": "board-lists"
            } 
          },
          "comments": { "data": [] }
        },
        "links": {"self": "/api/v1/issues/1"}
      }]
    }
    """
  And the response status should be "200"
