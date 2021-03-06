Feature: API: post /api/v1/documents

@javascript
Scenario: Create a document
  Given a test-organization exists and is loaded
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
        "id": "4",
        "type": "documents",
        "attributes": { 
          "name": "Test",
          "url": "/api/v1/document_files/1"
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
          "self": "/api/v1/documents/4"
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

  @javascript
  Scenario: Post an invalid record using json in POST body
    Given a test-organization exists and is loaded
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
