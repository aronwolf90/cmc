Feature: API: add chuncks to a document file

@javascript
Scenario: Create an contact
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type  | multipart/form-data        |
  When I send a multipart POST request to "/api/v1/document_files" with:
       | Name                | Content    | Filename      | Type        |
       | data[file]          |            | document0.txt | plain/txt   |
       | data[not_finished]  | true       |               |             |
  Then the JSON response should be:
    """
    {
      "data": {
        "id": "4",
        "type": "document-files",
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
  When I send a multipart PUT request to "/api/v1/document_files/4" with:
       | Name                | Content    | Filename      | Type          |
       | data[file]          |            | document1.txt | plain/txt     |            
  Then the response status should be "204"
