Feature: API: get board list

@javascript
Scenario: Get
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/board_lists/4"
  Then the JSON response should be:
    """
    { 
      "data":{ 
        "id":"4",
        "type":"board-lists",
        "attributes":{ 
          "name":"Backlog",
          "kind":"open"
        },
        "relationships":{ 
          "issues":{ 
            "data":[ 
              { 
                "id":"4",
                "type":"issues"
              },
              { 
                "id":"3",
                "type":"issues"
              },
              { 
                "id":"2",
                "type":"issues"
              },
              { 
                "id":"1",
                "type":"issues"
              }
            ],
            "links":{ 
              "self":"/api/v1/board_lists/4/issues"
            }
          },
          "project":{ 
            "data":{ 
              "id":"1",
              "type":"projects"
            }
          }
        },
        "links":{ 
          "self":"/api/v1/board_lists/4"
        },
        "meta":{ 
          "permissions":{ 
            "update":true,
            "destroy":false
          }
        }
      }
    }
    """
  And the response status should be "200"

@javascript
  Scenario: get api/v1/board_lists/<id>?filter[issue][project_id]=<project_id>
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
 And I send a GET request to "/api/v1/board_lists/1?filter[project_id]=2"
  Then the JSON response should be:
    """
    { 
      "data":{ 
        "id":"1",
        "type":"board-lists",
        "attributes":{ 
          "name":"Open",
          "kind":"open"
        },
        "relationships":{ 
          "issues":{ 
            "data":[ 
            ],
            "links":{ 
              "self":"/api/v1/board_lists/1/issues"
            }
          },
          "project":{ 
            "data": null 
          }
        },
        "links":{ 
          "self":"/api/v1/board_lists/1"
        },
        "meta":{ 
          "permissions":{ 
            "update":true,
            "destroy":false
          }
        }
      }
    }
    """
  And the response status should be "200"
