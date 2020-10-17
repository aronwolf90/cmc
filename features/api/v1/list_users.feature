Feature: API: list users

@javascript
Scenario: Get
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/users"
  Then the JSON response should match:
    """
    { 
      "meta": {
        "count": 3
      },
      "data":[ 
        { 
          "id":"1",
          "type":"users",
          "attributes":{ 
            "firstname": "Aron",
            "lastname": "Wolf",
            "email": "admin@lvh.me",
            "type": "Admin",
            "active": true,
            "records-count": 4,
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
        },
        { 
          "id":"2",
          "type":"users",
          "attributes":{ 
            "firstname":"user2",
            "lastname":"simson",
            "email":"employee@lvh.me",
            "type":"Employee",
            "active":true,
            "records-count":2,
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
    
              ]
            },
            "current-record":{ 
              "data":null
            }
          },
          "links":{ 
            "self":"/api/v1/users/2"
          },
          "meta":{ 
            "permissions":{ 
              "update":true,
              "destroy":true
            }
          }
        },
        { 
          "id":"3",
          "type":"users",
          "attributes":{ 
            "firstname":"user3",
            "lastname":"Herrera",
            "email":"customer@lvh.me",
            "type":"Customer",
            "active":true,
            "records-count":0,
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
    
              ]
            },
            "current-record":{ 
              "data":null
            }
          },
          "links":{ 
            "self":"/api/v1/users/3"
          },
          "meta":{ 
            "permissions":{ 
              "update":true,
              "destroy":true
            }
          }
        }
      ],
      "links":{ 
        "self":"/api/v1/users"
      }
    }
    """
  And the response status should be "200"
