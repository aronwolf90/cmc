Feature: API: create an record

@javascript
Scenario: Post an valid record using json in POST body
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a POST request to "/api/v1/records" with the following:
    """
    {
      "data": {
        "attributes": { "start-time": "2018-02-04T12:00:00.000Z" },
        "relationships": {
          "user": { "data": { "id": 1, "type": "users" } },
          "issue": { "data": { "id": 1, "type": "issues" } }
        }
      }
    }
    """
  Then the JSON response should be:
    """
    {
      "data": {
        "id": "7",
        "type": "records",
        "attributes": {
          "start-time": "2018-02-04T13:00:00.000+01:00",
          "end-time": null
        },
        "relationships": {
          "user": {"data": {"id": "1", "type": "users"}},
          "issue": {"data": {"id": "1", "type": "issues"}}
        },
        "links": {
          "self": "/api/v1/records/7"
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

@javascript
Scenario: Post an invalid record using json in POST body
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a POST request to "/api/v1/records" with the following:
    """
    {
      "data": {
        "attributes": { "start_time": null },
        "relationships": {
          "user": { "data": { "id": 1, "type": "admins" } },
          "issue": { "data": { "id": 1, "type": "issues" } }
        }
      }
    }
    """
  Then the response status should be "400"
