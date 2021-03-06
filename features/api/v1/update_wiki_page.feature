Feature: API: update an user

@javascript
Scenario: Put an valid record using json in PUT body
  Given a test-organization exists and is loaded
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
            "data": {"id": "3", "type": "wiki-categories"}
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

@javascript
Scenario: Put an invalid record using json in PUT body
  Given a test-organization exists and is loaded
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
