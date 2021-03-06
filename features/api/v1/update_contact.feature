Feature: API: update a contact

@javascript
Scenario: Put /api/v1/contacts/<id>
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a PUT request to "/api/v1/contacts/1" with the following:
    """
    {
      "data": {
        "id": 1,
        "type": "events",
        "attributes": {
          "kind": "company" 
        },
        "relationships": {
          "contact": {
            "name": "Contact" 
          }
        }
      }
    }
    """
  And the response status should be "204"

  @javascript
  Scenario: Put an invalid event using json in POST body
    Given a test-organization exists and is loaded
    And I set headers:
     | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
     | Content-Type | application/vnd.api+json |
    When I send a PUT request to "/api/v1/contacts/1" with the following:
    """
    {
      "data": {
        "id": 1,
        "type": "contacts",
        "attributes": { 
          "kind": null 
        }
      }
    }
    """
    Then the response status should be "400"
