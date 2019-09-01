Feature: API: path /api/v1/documents/1

Scenario: Create a document
  Given I am an user with an id of 1
  And a document exists with an id of 1
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a PUT request to "/api/v1/documents/1" with the following:
    """
    {
      "data": {
        "id": 1,
        "type": "documents",
        "attributes": { 
          "name": "New name"
        }
      }
    }
    """
  And the response status should be "204"
