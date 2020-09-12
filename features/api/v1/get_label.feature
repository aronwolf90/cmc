Feature: API: get folder

@javascript
Scenario: Get
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/labels/1"
  Then the response status should be "200"
  And the JSON response should be:
    """
    {
      "data": {
        "id": "1",
        "type": "labels",
        "attributes": {
          "name": "Bug",
          "color": "#ff0000"
        },
        "links": {
          "self": "/api/v1/labels/1"
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
