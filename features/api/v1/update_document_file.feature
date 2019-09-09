Feature: API: add chuncks to a document file

Scenario: Create an contact
  Given I am an user with an id of 1
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
        "id": "1",
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
  When I send a multipart PUT request to "/api/v1/document_files/1" with:
       | Name                | Content    | Filename      | Type          |
       | data[file]          |            | document1.txt | plain/txt     |            
  Then the response status should be "204"
