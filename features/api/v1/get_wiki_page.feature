Feature: API: get context

@javascript
Scenario: Get
  Given a test-organization exists and is loaded
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
          "content": "test content"
        },
        "relationships": {
          "wiki-category": {
            "data": {
              "id": "3",
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
