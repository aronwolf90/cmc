Feature: API: get folder

@javascript
Scenario: Get
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/records/1"
  Then the response status should be "200"
  And the JSON response should match:
    """
    {
      "data": {
        "id": "1",
        "type": "records",
        "attributes": {
          "description": "Test issue 5",
          "start-time": "<.+>",
          "end-time": "<.+>"
        },
        "links": {
          "self": "/api/v1/records/1"
        },
        "relationships": {
          "issue": { "data": { "id": "5", "type": "issues" } },
          "user": { "data": { "id": "1", "type": "users" } }
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
