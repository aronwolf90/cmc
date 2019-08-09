Feature: API: get the current record

Scenario: Get the current record from an user
  Given I am an user with an id of 1
  And I with an id of 1 have an current record
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/users/1/current_record"
  Then the JSON response should be:
    """
    {
      "data": {
        "id": "1",
        "type": "records",
        "attributes": {
          "start-time": "2018-02-04T13:00:00.000+01:00",
          "end-time": null
        },
        "relationships": {
          "user": {
            "data": {
              "id": "1",
              "type": "admins"
            }
          },
          "issue": {
            "data": null
          }
        },
        "links": {
          "self": "/api/v1/records/1"
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
