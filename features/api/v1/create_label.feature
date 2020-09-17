Feature: API: create a label

@javascript
Scenario: POST /api/v1/labels
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a POST request to "/api/v1/labels" with the following:
    """
    {
      "data": {
        "attributes": {
          "name": "warning",
          "color": "#FFFF00"
        }
      }
    }
    """
  Then the response status should be "201"
  And the JSON response should be:
    """
    {
      "data": {
        "id": "3",
        "type": "labels",
        "attributes": {
          "name": "warning",
          "color": "#FFFF00"
        },
        "links": {
          "self": "/api/v1/labels/3"
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
