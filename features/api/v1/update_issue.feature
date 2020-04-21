Feature: API: update an issue

@javascript
Scenario: Put an valid issue using json in PUT body
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a PUT request to "/api/v1/issues/1" with the following:
    """
    {
      "data": {
        "id": 1,
        "type": "issues",
        "attributes": {
          "title": "title",
          "due-at": "12-10-2020 00:00",
          "deadline-at": "12-10-2020 00:00"
        }
      }
    }
    """
  Then the response status should be "204"
  When I send a GET request to "/api/v1/issues/1"
  Then the response status should be "200"
  And the JSON response should be:
    """
    { 
      "data":{ 
        "id":"1",
        "type":"issues",
        "attributes":{ 
          "title":"title",
          "description":"description for the test issue",
          "complexity":"2.0",
          "due-at":"12-10-2020 00:00",
          "deadline-at":"12-10-2020 00:00"
        },
        "relationships":{ 
          "user":{ 
            "data":{ 
              "id":"1",
              "type":"users"
            }
          },
          "board-list":{ 
            "data":{ 
              "id":"4",
              "type":"board-lists"
            }
          }
        },
        "links":{ 
          "self":"/api/v1/issues/1"
        },
        "meta":{ 
          "permissions":{ 
            "update":true,
            "destroy":true
          }
        }
      }
    }
    """

@javascript
Scenario: Put an invalid issue using json in PUT body
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a PUT request to "/api/v1/issues/1" with the following:
    """
    {
      "data": {
        "attributes": { "title": null }
      }
    }
    """
  Then the response status should be "400"
