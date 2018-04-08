Feature: API: update an issue

Scenario: Put an valid issue using json in PUT body
  Given an issue exists with an id of 1
  And I am an user with an id of 1
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a PUT request to "/api/v1/issues/1" with the following:
    """
    {
      "data": {
        "id": 1,
        "type": "records",
        "attributes": { "title": "title" }
      }
    }
    """
  Then the response status should be "204"

Scenario: Put an invalid issue using json in PUT body
  Given an issue exists with an id of 1
  And I am an user with an id of 1
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
