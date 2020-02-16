Feature: API: update board list order

@javascript
Scenario: valid data
  Given a test-organization exists and is loaded
  And I set headers:
    | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
    | Content-Type | application/vnd.api+json |
  When I send a PUT request to "/api/v1/board_lists/sort" with the following:
    """
      {
        "data": [2, 1]
      }
    """
  Then the response status should be "204"
  When I send a GET request to "/api/v1/board_lists"
  Then the JSON response should be:
    """
    { 
      "data":[ 
        { 
          "id":"2",
          "type":"board-lists",
          "attributes":{ 
            "name":"In development"
          },
          "relationships":{ 
            "issues":{ 
              "data":[ 
                { 
                  "id":"7",
                  "type":"issues"
                },
                { 
                  "id":"6",
                  "type":"issues"
                },
                { 
                  "id":"5",
                  "type":"issues"
                }
              ],
              "links":{ 
                "self":"/api/v1/board_lists/2/issues"
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
            "self":"/api/v1/board_lists/2"
          },
          "meta":{ 
            "permissions":{ 
              "update":true,
              "destroy":true
            }
          }
        },
        { 
          "id":"1",
          "type":"board-lists",
          "attributes":{ 
            "name":"Backlog"
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
                "self":"/api/v1/board_lists/1/issues"
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
            "self":"/api/v1/board_lists/1"
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
          "type":"board-lists",
          "attributes":{ 
            "name":"Closed"
          },
          "relationships":{ 
            "issues":{ 
              "data":[ 
                { 
                  "id":"11",
                  "type":"issues"
                },
                { 
                  "id":"10",
                  "type":"issues"
                },
                { 
                  "id":"9",
                  "type":"issues"
                },
                { 
                  "id":"8",
                  "type":"issues"
                }
              ],
              "links":{ 
                "self":"/api/v1/board_lists/3/issues"
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
            "self":"/api/v1/board_lists/3"
          },
          "meta":{ 
            "permissions":{ 
              "update":true,
              "destroy":true
            }
          }
        },
        { 
          "id":"4",
          "type":"board-lists",
          "attributes":{ 
            "name":"Test project 2 open"
          },
          "relationships":{ 
            "issues":{ 
              "data":[ 
    
              ],
              "links":{ 
                "self":"/api/v1/board_lists/4/issues"
              }
            },
            "project":{ 
              "data":{ 
                "id":"2",
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
              "destroy":true
            }
          }
        }
      ],
      "links":{ 
        "self":"/api/v1/board_lists"
      }
    }
    """

@javascript
Scenario: inalid data
  Given a test-organization exists and is loaded
  And I set headers:
    | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
    | Content-Type | application/vnd.api+json |
  When I send a PUT request to "/api/v1/board_lists/sort" with the following:
    """
    {
      "data": null
    }
    """
  Then the response status should be "400"
