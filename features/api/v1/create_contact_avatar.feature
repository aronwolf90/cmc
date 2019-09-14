Feature: API: create a contact avatar

Scenario: Create an contact
  Given I am an user with an id of 1
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type  | multipart/form-data        |
  When I send a multipart POST request to "/api/v1/contact_avatars" with:
       | Name                | Content    | Filename      | Type       |
       | data[file] |        | avatar.jpg | image/jpeg    |
  Then the JSON response should be:
    """
    {
      "data": {
        "id": "1",
        "type": "contact-avatars",
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
