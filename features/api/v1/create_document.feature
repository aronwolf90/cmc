Feature: API: post /api/v1/documents

Scenario: Create a document
  Given I am an user with an id of 1
  And a document_file exists with an id of 1
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a POST request to "/api/v1/documents" with the following:
    """
    {
      "data": {
        "attributes": { 
          "name": "Test",
          "document-file-id": "1"
        },
        "relationships": {
          "folder": {
            "data": {
              "id": 1,
              "type": "folders"
            }
          }
        }
      }
    }
    """
  Then the JSON response should be:
    """
    {
      "data": {
        "id": "2",
        "type": "documents",
        "attributes": { 
          "name": "Test"
        },
        "relationships": {
          "folder": {
            "data": {
              "id": "1",
              "type": "folders"
            }
          }
        },
        "links": {
          "self": "/api/v1/documents/2"
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

  Scenario: Post an invalid record using json in POST body
    Given I am an user with an id of 1
    And I set headers:
     | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
     | Content-Type | application/vnd.api+json |
    When I send a POST request to "/api/v1/documents" with the following:
      """
      {
        "data": {
          "attributes": { 
            "name": null
          }
        }
      }
      """
    Then the response status should be "400"
