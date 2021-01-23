Feature: API: post /api/v1/wiki_categories

@javascript
Scenario: Create a wiki-category
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a POST request to "/api/v1/wiki_categories" with the following:
    """
    {
      "data": {
        "attributes": { 
          "title": "Test"
        },
        "relationships": {
          "wiki-category": {
            "data": {
              "id": 1,
              "type": "wiki-categories"
            }
          }
        }
      }
    }
    """
  Then the response status should be "201"
  And the JSON response should match:
    """
    {
      "data": {
        "id": "<.*>",
        "type": "wiki-categories",
        "attributes": { 
          "title": "Test",
          "root": false
        },
        "relationships": {
          "wiki-category": {
            "data": {
              "id": "1",
              "type": "wiki-categories"
            }
          },
          "wiki-pages": {
            "data": []
          },
          "wiki-categories": {
            "data": []
          }
        },
        "links": {
          "self": "/api/v1/wiki_categories/<.*>"
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
  And the response status should be "201"
