Feature: API: update an user

Scenario: Put an valid record using json in PUT body
  Given a wiki page exists with an id of 1
  And I am an user with an id of 1
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a PATCH request to "/api/v1/wiki_pages/1" with the following:
    """
    {
      "data": {
        "id": 1,
        "type": "wiki-pages",
        "attributes": {
          "title": "new title",
          "content": "new content" 
        }
      }
    }
    """
  Then the response status should be "204"
  When I send a GET request to "/api/v1/wiki_pages/1"
  Then the JSON response should be:
    """
    {
      "data": {
        "id": "1",
        "type": "wiki-pages",
        "attributes": {
          "title": "new title",
          "content": "new content" 
        },
        "relationships": {
          "wiki-category": {
            "data": {"id": "1", "type": "wiki-categories"}
          }
        },
        "links": { "self": "/api/v1/wiki_pages/1" }
      }
    }
    """

Scenario: Put an invalid record using json in PUT body
  Given a wiki page exists with an id of 1
  And I am an user with an id of 1
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a PATCH request to "/api/v1/wiki_pages/1" with the following:
    """
    {
      "data": {
        "id": "1",
        "type": "users",
        "attributes": {
          "title": ""
        }
      }
    }
    """
  Then the response status should be "400"
