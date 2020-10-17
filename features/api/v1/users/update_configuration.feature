Feature: API: PATCH /users/<id>/configuration

Scenario: Update successfully user type when updater is a admin
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a PUT request to "/api/v1/users/2/configuration" with the following:
    """
    {
      "data": {
        "id": "2",
        "type": "users",
        "attributes": {
          "type": "Customer",
          "active": false
        }
      }
    }
    """
  Then the response status should be "200"
  And the JSON response should match:
    """
    {
      "data": {
        "id": "2",
        "type": "users",
        "attributes": { 
          "firstname": "user2",
          "lastname": "simson",
          "email": "employee@lvh.me",
          "type": "Customer",
          "active": false,
          "records-count": 2,
          "avatar-url": "/packs/images/avatar_placeholder<.+>" 
        },
        "relationships": {
          "selected-project": {
            "data": {
              "id": "1",
              "type": "projects"
            }
          },
          "issues": { "data": [] },
          "current-record": { "data": null }
        },
        "links": {"self": "/api/v1/users/2"},
        "meta": {
          "permissions": {
            "update": true,
            "destroy": true
          }
        }
      }
    }
    """

Scenario: Update type fail type when updater is a employee
  Given a test-organization exists and is loaded
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
