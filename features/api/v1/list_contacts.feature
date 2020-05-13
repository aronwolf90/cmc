Feature: API: list issues

@javascript
Scenario: Get /api/v1/contacts
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/contacts"
  Then the JSON response should be:
    """
    {
      "meta": {
        "count": 2 
      },
      "data":[
        {
          "id":"1",
          "type":"contacts",
          "attributes":{
            "name":"Clara",
            "description":"Test description",
						"email": "clara@test.example",
            "telephone":"01707986607",
            "mobile":"01707986617",
            "fax":"01707986617",
            "address-city":"Barcelona",
            "address-zip":"08001",
            "address-country":"Spain",
            "address-street":"Las Holletas",
            "address-number":"5",
            "avatar-url":"/api/v1/contact_avatars/placeholder"
          },
          "links":{
            "self":"/api/v1/contacts/1"
          },
          "meta":{
            "permissions":{
              "update":true,
              "destroy":true
            }
          }
        },
        {
          "id":"2",
          "type":"contacts",
          "attributes":{
            "name":"Project",
            "description":"Test description",
						"email": "clara@test.example",
            "telephone":"01707986607",
            "mobile":"01707986617",
            "fax":"01707986617",
            "address-city":"Barcelona",
            "address-zip":"08001",
            "address-country":"Spain",
            "address-street":"Las Holletas",
            "address-number":"5",
            "avatar-url":"/api/v1/contact_avatars/placeholder"
          },
          "links":{
            "self":"/api/v1/contacts/2"
          },
          "meta":{
            "permissions":{
              "update":true,
              "destroy":true
            }
          }
        }
      ],
      "links":{
        "self":"/api/v1/contacts"
      }
    }
    """
  And the response status should be "200"
