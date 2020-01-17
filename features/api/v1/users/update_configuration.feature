Feature: API: PATCH /users/<id>/configuration

Scenario: Update successfully user type when updater is a admin
  Given The app contain seed data
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a PUT request to "/api/v1/users/1/configuration" with the following:
    """
    {
      "data": {
        "id": "2",
        "type": "users",
        "attributes": {
          "type": "Customer"
        }
      }
    }
    """
  And the response status should be "204"

Scenario: Update type fail type when updater is a employee
  Given The app contain seed data
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjJ9.Z4Z9D_QEKSg5mwtQCQYM8u3bgj_GjNBzsDfdy0Bpgok |
   | Content-Type | application/vnd.api+json |
  And I send a PUT request to "/api/v1/users/1/configuration" with the following:
    """
    {
      "data": {
        "id": "2",
        "type": "users",
        "attributes": {
          "type": "Customer"
        }
      }
    }
    """
  And the response status should be "400"
