Feature: API: list users

Scenario: Get
  Given I am an user with an id of 1
  And a wiki category with an id of 1 exists
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/wiki_categories"
  Then the JSON response should be:
    """
    {
      "data": [{
        "id": "1",
        "type": "wiki-categories",
        "attributes": {
          "title": "wiki category title",
          "root": true
        },
        "relationships": {
          "wiki-category": { "data": null },
          "wiki-categories": { "data": [] },
          "wiki-pages": { "data": [] }
        },
        "meta": {
          "permissions": {
            "update": true,
            "destroy": true
          }
        }
      }],
      "links": { "self": "/api/v1/wiki_categories" }
    }
    """
  And the response status should be "200"
