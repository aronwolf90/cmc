Feature: API: List board_lists issues

Scenario: GET /api/v1/board_lists/<id>/issues
  Given The app contain seed data
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a GET request to "/api/v1/board_lists/1/issues"
  Then the JSON response should be:
    """
    { 
      "data":[ 
        { 
          "id":"4",
          "type":"issues",
          "attributes":{ 
            "title":"Test issue 4",
            "description":"description for the test issue",
            "complexity":"5.0"
          },
          "relationships":{ 
            "user":{ 
              "data":null
            },
            "board-list":{ 
              "data":{ 
                "id":"1",
                "type":"board-lists"
              }
            },
            "comments":{ 
              "data":[ 
    
              ]
            }
          },
          "links":{ 
            "self":"/api/v1/issues/4"
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
          "type":"issues",
          "attributes":{ 
            "title":"Test issue 3",
            "description":"description for the test issue",
            "complexity":"3.0"
          },
          "relationships":{ 
            "user":{ 
              "data":null
            },
            "board-list":{ 
              "data":{ 
                "id":"1",
                "type":"board-lists"
              }
            },
            "comments":{ 
              "data":[ 
    
              ]
            }
          },
          "links":{ 
            "self":"/api/v1/issues/3"
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
          "type":"issues",
          "attributes":{ 
            "title":"Test issue 2",
            "description":"description for the test issue",
            "complexity":"2.0"
          },
          "relationships":{ 
            "user":{ 
              "data":{ 
                "id":"1",
                "type":"users"
              }
            },
            "board-list":{ 
              "data":{ 
                "id":"1",
                "type":"board-lists"
              }
            },
            "comments":{ 
              "data":[ 
    
              ]
            }
          },
          "links":{ 
            "self":"/api/v1/issues/2"
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
          "type":"issues",
          "attributes":{ 
            "title":"Test issue 1",
            "description":"description for the test issue",
            "complexity":"2.0"
          },
          "relationships":{ 
            "user":{ 
              "data":{ 
                "id":"1",
                "type":"users"
              }
            },
            "board-list":{ 
              "data":{ 
                "id":"1",
                "type":"board-lists"
              }
            },
            "comments":{ 
              "data":[ 
    
              ]
            }
          },
          "links":{ 
            "self":"/api/v1/issues/1"
          },
          "meta":{ 
            "permissions":{ 
              "update":true,
              "destroy":true
            }
          }
        }
      ],
		  "links": { "next": null }
    }
    """
  And the response status should be "200"