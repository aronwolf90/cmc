Feature: API: list board lists

@javascript
Scenario: Get
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/board_lists"
  Then the JSON response should be:
    """
    { 
      "data":[ 
        { 
          "id":"4",
          "type":"board-lists",
          "attributes":{ 
            "name":"Backlog",
            "kind":"open",
            "complexity": "12.0"
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
        },
        { 
          "id":"5",
          "type":"board-lists",
          "attributes":{ 
            "name":"In development",
            "kind":"other",
            "complexity": "18.0"
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
                "self":"/api/v1/board_lists/5/issues"
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
            "self":"/api/v1/board_lists/5"
          },
          "meta":{ 
            "permissions":{ 
              "update":true,
              "destroy":false
            }
          }
        },
        { 
          "id":"6",
          "type":"board-lists",
          "attributes":{ 
            "name":"Closed",
            "kind":"closed",
            "complexity": "17.0"
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
                "self":"/api/v1/board_lists/6/issues"
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
            "self":"/api/v1/board_lists/6"
          },
          "meta":{ 
            "permissions":{ 
              "update":true,
              "destroy":false
            }
          }
        },
        { 
          "id":"7",
          "type":"board-lists",
          "attributes":{ 
            "name":"Test project 2 open",
            "kind":"open",
            "complexity": "5.0"
          },
          "relationships":{ 
            "issues":{ 
              "data":[{
							  "id": "12",
								"type": "issues"
							}],
              "links":{ 
                "self":"/api/v1/board_lists/7/issues"
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
            "self":"/api/v1/board_lists/7"
          },
          "meta":{ 
            "permissions":{ 
              "update":true,
              "destroy":false
            }
          }
        },
        { 
          "id":"8",
          "type":"board-lists",
          "attributes":{ 
            "name":"In development",
            "kind":"other",
            "complexity": "0.0"
          },
          "relationships":{ 
            "issues":{ 
              "data":[ 
    
              ],
              "links":{ 
                "self":"/api/v1/board_lists/8/issues"
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
            "self":"/api/v1/board_lists/8"
          },
          "meta":{ 
            "permissions":{ 
              "update":true,
              "destroy":true
            }
          }
        },
        { 
          "id":"9",
          "type":"board-lists",
          "attributes":{ 
            "name":"Closed",
            "kind":"closed",
            "complexity": "0.0"
          },
          "relationships":{ 
            "issues":{ 
              "data":[ 
    
              ],
              "links":{ 
                "self":"/api/v1/board_lists/9/issues"
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
            "self":"/api/v1/board_lists/9"
          },
          "meta":{ 
            "permissions":{ 
              "update":true,
              "destroy":false
            }
          }
        }
      ],
      "links": {
        "self": "/api/v1/board_lists"
      }
    }
    """
  And the response status should be "200"

@javascript
  Scenario: Get filter[project_id]=<project_id>
  Given a test-organization with global board_list exits and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/board_lists?filter[project_id]=1"
  Then the response status should be "200"
  And the JSON response should be:
    """
      {
        "data": [
          {
            "id": "1",
            "type": "board-lists",
            "attributes": {
              "name": "Open",
              "kind": "open",
              "complexity": "12.0"
            },
            "relationships": {
              "issues": {
                "data": [
                  {
                    "id": "4",
                    "type": "issues"
                  },
                  {
                    "id": "3",
                    "type": "issues"
                  },
                  {
                    "id": "2",
                    "type": "issues"
                  },
                  {
                    "id": "1",
                    "type": "issues"
                  }
                ],
                "links": {
                  "self": "/api/v1/board_lists/1/issues"
                }
              },
              "project": {
                "data": null
              }
            },
            "links": {
              "self": "/api/v1/board_lists/1"
            },
            "meta": {
              "permissions": {
                "update": true,
                "destroy": false
              }
            }
          },
          {
            "id": "2",
            "type": "board-lists",
            "attributes": {
              "name": "In progress",
              "kind": "other",
              "complexity": "18.0"
            },
            "relationships": {
              "issues": {
                "data": [
                  {
                    "id": "7",
                    "type": "issues"
                  },
                  {
                    "id": "6",
                    "type": "issues"
                  },
                  {
                    "id": "5",
                    "type": "issues"
                  }
                ],
                "links": {
                  "self": "/api/v1/board_lists/2/issues"
                }
              },
              "project": {
                "data": null
              }
            },
            "links": {
              "self": "/api/v1/board_lists/2"
            },
            "meta": {
              "permissions": {
                "update": true,
                "destroy": false
              }
            }
          },
          {
            "id": "3",
            "type": "board-lists",
            "attributes": {
              "name": "Closed",
              "kind": "closed",
              "complexity": "17.0"
            },
            "relationships": {
              "issues": {
                "data": [
                  {
                    "id": "11",
                    "type": "issues"
                  },
                  {
                    "id": "10",
                    "type": "issues"
                  },
                  {
                    "id": "9",
                    "type": "issues"
                  },
                  {
                    "id": "8",
                    "type": "issues"
                  }
                ],
                "links": {
                  "self": "/api/v1/board_lists/3/issues"
                }
              },
              "project": {
                "data": null
              }
            },
            "links": {
              "self": "/api/v1/board_lists/3"
            },
            "meta": {
              "permissions": {
                "update": true,
                "destroy": false
              }
            }
          }
        ],
        "links": {
          "self": "/api/v1/board_lists"
        }
      }
    """
