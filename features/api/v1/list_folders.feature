Feature: API: list users

@javascript
Scenario: Get
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/folders"
  Then the JSON response should be:
    """
    {
      "data": [
        {
          "id": "1",
          "type": "folders",
          "attributes": {
            "name": "Test project",
            "root": true
          },
          "relationships": {
            "project": {
              "data": {
                "id": "1",
                "type": "projects"
              }
            },
            "folder": {
              "data": null
            },
            "folders": {
              "data": [

              ]
            },
            "documents": {
              "data": [
                {
                  "id": "1",
                  "type": "documents"
                }
              ]
            }
          },
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          },
          "links": {
            "self": "/api/v1/folders/1"
          }
        },
        {
          "id": "2",
          "type": "folders",
          "attributes": {
            "name": "Test project 1",
            "root": true
          },
          "relationships": {
            "project": {
              "data": {
                "id": "2",
                "type": "projects"
              }
            },
            "folder": {
              "data": null
            },
            "folders": {
              "data": [

              ]
            },
            "documents": {
              "data": [
                {
                  "id": "2",
                  "type": "documents"
                }
              ]
            }
          },
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          },
          "links": {
            "self": "/api/v1/folders/2"
          }
        },
        {
          "id": "3",
          "type": "folders",
          "attributes": {
            "name": "folder 1",
            "root": true
          },
          "relationships": {
            "project": {
              "data": null
            },
            "folder": {
              "data": null
            },
            "folders": {
              "data": [
                {
                  "id": "4",
                  "type": "folders"
                }
              ]
            },
            "documents": {
              "data": [
                {
                  "id": "3",
                  "type": "documents"
                }
              ]
            }
          },
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          },
          "links": {
            "self": "/api/v1/folders/3"
          }
        },
        {
          "id": "4",
          "type": "folders",
          "attributes": {
            "name": "folder 2",
            "root": false
          },
          "relationships": {
            "project": {
              "data": null
            },
            "folder": {
              "data": {
                "id": "3",
                "type": "folders"
              }
            },
            "folders": {
              "data": [

              ]
            },
            "documents": {
              "data": [

              ]
            }
          },
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          },
          "links": {
            "self": "/api/v1/folders/4"
          }
        },
        {
          "id": "5",
          "type": "folders",
          "attributes": {
            "name": "Test project 3",
            "root": true
          },
          "relationships": {
            "project": {
              "data": {
                "id": "3",
                "type": "projects"
              }
            },
            "folder": {
              "data": null
            },
            "folders": {
              "data": [

              ]
            },
            "documents": {
              "data": [

              ]
            }
          },
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          },
          "links": {
            "self": "/api/v1/folders/5"
          }
        },
        {
          "id": "6",
          "type": "folders",
          "attributes": {
            "name": "Test project 4",
            "root": true
          },
          "relationships": {
            "project": {
              "data": {
                "id": "4",
                "type": "projects"
              }
            },
            "folder": {
              "data": null
            },
            "folders": {
              "data": [

              ]
            },
            "documents": {
              "data": [

              ]
            }
          },
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          },
          "links": {
            "self": "/api/v1/folders/6"
          }
        },
        {
          "id": "7",
          "type": "folders",
          "attributes": {
            "name": "Test project 5",
            "root": true
          },
          "relationships": {
            "project": {
              "data": {
                "id": "5",
                "type": "projects"
              }
            },
            "folder": {
              "data": null
            },
            "folders": {
              "data": [

              ]
            },
            "documents": {
              "data": [

              ]
            }
          },
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          },
          "links": {
            "self": "/api/v1/folders/7"
          }
        },
        {
          "id": "8",
          "type": "folders",
          "attributes": {
            "name": "Test project 6",
            "root": true
          },
          "relationships": {
            "project": {
              "data": {
                "id": "6",
                "type": "projects"
              }
            },
            "folder": {
              "data": null
            },
            "folders": {
              "data": [

              ]
            },
            "documents": {
              "data": [

              ]
            }
          },
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          },
          "links": {
            "self": "/api/v1/folders/8"
          }
        },
        {
          "id": "9",
          "type": "folders",
          "attributes": {
            "name": "Test project 7",
            "root": true
          },
          "relationships": {
            "project": {
              "data": {
                "id": "7",
                "type": "projects"
              }
            },
            "folder": {
              "data": null
            },
            "folders": {
              "data": [

              ]
            },
            "documents": {
              "data": [

              ]
            }
          },
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          },
          "links": {
            "self": "/api/v1/folders/9"
          }
        },
        {
          "id": "10",
          "type": "folders",
          "attributes": {
            "name": "Test project 8",
            "root": true
          },
          "relationships": {
            "project": {
              "data": {
                "id": "8",
                "type": "projects"
              }
            },
            "folder": {
              "data": null
            },
            "folders": {
              "data": [

              ]
            },
            "documents": {
              "data": [

              ]
            }
          },
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          },
          "links": {
            "self": "/api/v1/folders/10"
          }
        }
      ],
      "links": {
        "self": "/api/v1/folders"
      },
      "meta": {
        "count": 19
      }
    }
    """
  And the response status should be "200"
