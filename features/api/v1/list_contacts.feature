Feature: API: list issues

Scenario: Get /api/v1/contacts
  Given a contact exists with an id of 1
  And I am an user with an id of 1
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/contacts"
  Then the JSON response should be:
    """
    {
      "data": [{
        "id": "1",
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
          "address-number": "8"
        },
        "relationships": {
          "contact-avatar": {
            "data": {
              "id": "1",
              "type": "contact-avatars"
            }
          }
        },
        "links": {
          "self": "/api/v1/contacts/1"
        },
        "meta": {
          "permissions": {
            "update": true,
            "destroy": true
          }
        }
      }],
      "links": { "self": "/api/v1/contacts" }
    }
    """
  And the response status should be "200"
