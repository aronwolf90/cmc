Feature: API: list users

@javascript
Scenario: Get
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/labels"
  Then the JSON response should be:
    """
    { 
      "meta": {
        "count": 2
      },
      "data":[ 
        { 
          "id":"1",
          "type":"labels",
          "attributes":{ 
            "name": "Bug",
            "color": "#ff0000"
          },
          "links": {
            "self": "/api/v1/labels/1"
          },
          "meta":{ 
            "permissions":{ 
              "update":true,
              "destroy":true
            }
          }
        },
        { 
          "id":"2",
          "type":"labels",
          "attributes":{ 
            "name": "Important",
            "color": "#ff0000"
          },
          "links": {
            "self": "/api/v1/labels/2"
          },
          "meta":{ 
            "permissions":{ 
              "update":true,
              "destroy":true
            }
          }
        }
      ],
      "links":{ 
        "self":"/api/v1/labels"
      }
    }
    """
  And the response status should be "200"
