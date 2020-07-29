Feature: API: get context

@javascript
Scenario: Get
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/context"
  Then the JSON response should be:
    """
    {
      "data": {
        "id": "context",
        "type": "contexts",
        "attributes": {
          "premium": false, 
          "user-count": 3,
          "global-board": false,
          "time-zone": "Berlin",
          "google-calender-integrated": false,
					"google-calender-authorization-url": "https://accounts.google.com/o/oauth2/auth?access_type=offline&client_id=634131184869-qt64vu47i164012oc80l7ga8f1mf61aj.apps.googleusercontent.com&redirect_uri=http://lvh.me:3000/google_calenders/create_callback&response_type=code&scope=https://www.googleapis.com/auth/calendar&state=test-organization"
        },
        "relationships": {
          "current-user": { "data": { "id": "1", "type": "users" } }
        },
        "links": { "self": "/api/v1/context" }
      },
      "included": [{
        "id": "1",
        "type": "users",
        "attributes": {
          "firstname": "Aron",
          "lastname": "Wolf",
          "email": "admin@lvh.me",
          "type": "Admin",
          "active": true,
          "records-count": 4
        },
        "relationships": {
          "selected-project": { "data": { "id": "1", "type": "projects" } },
          "issues": {
            "data": [
              { "id": "1", "type": "issues" },
              { "id": "2", "type": "issues" }
            ]
          },
          "current-record": { "data": null }
        },
        "links": {
          "self": "/api/v1/users/1"
        },
        "meta": {
          "permissions": {
            "update": true,
            "destroy": true
          }
        }
      }]
    }
    """
  And the response status should be "200"
