Feature: API: update context

  @javascript
  Scenario: Update an user
    Given a test-organization exists and is loaded
    And I set headers:
     | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
     | Content-Type | application/vnd.api+json |
    When I send a PATCH request to "/api/v1/context" with the following:
      """
      {
        "data": {
          "id": "context",
          "type": "contexts",
          "attributes": { 
            "time-zone": "Madrid",
            "global-board": true
          }
        }
      }
      """
    Then the response status should be "200"
    When I send a GET request to "/api/v1/context"
    Then the response status should be "200"
    And the JSON response should match:
      """
      {
         "data":{
            "id":"context",
            "type":"contexts",
            "attributes":{
               "premium":false,
               "user-count":3,
               "time-zone":"Madrid",
               "global-board":true,
               "google-calendar-authorization-url": "<.*>",
               "google-calendar-integrated": false
            },
            "relationships":{
               "current-user":{
                  "data":{
                     "id":"1",
                     "type":"users"
                  }
               }
            },
						"links": { "self": "/api/v1/context" }
         },
         "included":[
            {
               "id":"1",
               "type":"users",
               "attributes":{
                  "firstname":"Aron",
                  "lastname":"Wolf",
                  "email":"admin@lvh.me",
                  "type":"Admin",
                  "active":true,
                  "records-count":4,
                  "avatar-url": "/packs/images/avatar_placeholder<.+>" 
               },
               "relationships":{
                  "selected-project":{
                     "data":{
                        "id":"1",
                        "type":"projects"
                     }
                  },
                  "issues":{
                     "data":[
                        {
                           "id":"1",
                           "type":"issues"
                        },
                        {
                           "id":"2",
                           "type":"issues"
                        }
                     ]
                  },
                  "current-record":{
                     "data":null
                  }
               },
               "links":{
                  "self":"/api/v1/users/1"
               },
               "meta":{
                  "permissions":{
                     "update":true,
                     "destroy":true
                  }
               }
            }
         ]
      }
      """
