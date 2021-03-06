Feature: API: create a user avatar

@javascript
Scenario: Create an user avatar
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type  | multipart/form-data        |
  When I send a multipart POST request to "/api/v1/user_avatars" with:
       | Name                | Content    | Filename      | Type       |
       | data[file] |        | avatar.jpg | image/jpeg    |
  Then the response status should be "201"
  And the JSON response should be:
    """
    {
      "data": {
        "id": "1",
        "type": "user-avatars",
        "meta": {
          "permissions": {
            "update": true, 
            "destroy": true
          }
        }
      }
    }
    """
