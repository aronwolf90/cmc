Feature: API: create an record

Scenario: Post an valid record using json in POST body
  Given I am an user with an id of 1
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And an issue exists with an id of 1
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
        "id": "1",
        "type": "records",
        "attributes": { "start-time": "2018-02-04T13:00:00.000+01:00", "end-time": null },
        "relationships": {
          "user": {"data": {"id": "1", "type": "users"}},
          "issue": {"data": {"id": "1", "type": "issues"}}
        },
        "links": {"self": "/api/v1/records/1"}
      }
    }
    """
  And the response status should be "201"

  Scenario: Post an invalid record using json in POST body
    Given I am an user with an id of 1
    And an issue exists with an id of 1
    And I set headers:
     | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
     | Content-Type | application/vnd.api+json |
    When I send a POST request to "/api/v1/records" with the following:
      """
      {
        "data": {
          "attributes": { "start_time": null },
          "relationships": {
            "user": { "data": { "id": 1, "type": "users" } },
            "issue": { "data": { "id": 1, "type": "issues" } }
          }
        }
      }
      """
    Then the response status should be "400"
