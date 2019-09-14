Feature: API: get context

Scenario: Get
  Given I am an user with an id of 1
  And a wiki category exists with an id of "1"
  And the following wiki page exist:
   | id | wiki_category_id |
   | 1  | 1                |
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/wiki_pages/1"
  Then the JSON response should be:
    """
    {
      "data": {
        "id": "1",
        "type": "wiki-pages",
        "attributes": {
          "title": "wiki page title",
          "content": "wiki page content"
        },
        "relationships": {
          "wiki-category": {
            "data": {
              "id": "1",
              "type": "wiki-categories"
            }
          }
        },
        "links": {
          "self": "/api/v1/wiki_pages/1"
        },
        "meta": {
          "permissions": {
            "update": true, 
            "destroy": true
          }
        }
      }
    }
    """
  And the response status should be "200"
