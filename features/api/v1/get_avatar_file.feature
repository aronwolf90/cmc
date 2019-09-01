Feature: API: get contact_avatars/<id>

Scenario: Get
  Given an issue exists with an id of 1
  And I am an user with an id of 1
  And a contact avatar exists with an id of 1
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/contact_avatars/1"
  Then the response status should be "200"
	And has the following headers:
	 | Content-Type | image/jpeg |
