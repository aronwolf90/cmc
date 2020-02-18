Feature: API: create an record

@javascript
Scenario: Create an contact of kind "person"
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a POST request to "/api/v1/contacts" with the following:
    """
    {
      "data": {
        "attributes": { 
          "name": "Frantz",
          "description": "Test description",
          "address-city": "Augsburg",
          "address-zip": "86153",
          "address-country": "germany",
          "address-street": "Street",
          "address-number": "8",
          "telephone": "01727873609",
          "mobile": "01702876609",
          "fax": "01727876620",
          "contact-avatar-id": "1"
        }
      }
    }
    """
  Then the JSON response should be:
    """
    {
      "data": {
        "id": "2",
        "type": "contacts",
        "attributes": { 
          "name": "Frantz",
          "description": "Test description",
          "telephone": "01727873609",
          "mobile": "01702876609",
          "fax": "01727876620",
          "address-city": "Augsburg",
          "address-zip": "86153",
          "address-country": "germany",
          "address-street": "Street",
          "address-number": "8",
          "avatar-url": "/api/v1/contact_avatars/placeholder"
        },
        "meta": {
          "permissions": {
            "update": true, 
            "destroy": true
          }
        },
        "links": {"self": "/api/v1/contacts/2"}
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
          "attributes": { "kind": null }
        }
      }
      """
    Then the response status should be "400"
