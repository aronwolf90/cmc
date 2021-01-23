Feature: API: create a wiki category

  @javascript
  Scenario: Update a wiki category
    Given a test-organization exists and is loaded
    And I set headers:
     | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
     | Content-Type | application/vnd.api+json |
    When I send a PUT request to "/api/v1/wiki_categories/2" with the following:
      """
      {
        "data": {
          "id": "2",
          "type": "users",
          "attributes": { 
            "titlte": "Test title"
          }
        }
      }
      """
    And the response status should be "204"
