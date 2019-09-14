Feature: API: destroy an attendance event

Scenario: Destroy an attendance event
  Given I am an user with an id of 1
  And the following attendance event exist:
	 | id | user_id |
	 | 1  | 1       |
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a DELETE request to "/api/v1/attendance_events/1"
  Then the response status should be "200"
