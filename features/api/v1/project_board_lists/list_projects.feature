Feature: API: List board_lists issues

@javascript
Scenario: GET /api/v1/board_lists/<id>/issues
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a GET request to "/api/v1/project_board_lists/1/projects"
  Then the response status should be "200"
  And the JSON response should be:
    """
    {
      "data": [
        {
          "id": "1",
          "type": "projects",
          "attributes": {
            "name": "Test project",
            "description": "Test description"
          },
          "relationships": {
            "project-status": {
              "data": {
                "id": "1",
                "type": "project-statuses"
              }
            },
            "main-responsable": {
              "data": null
            },
            "folder": {
              "data": {
                "id": "1",
                "type": "folders"
              },
              "links": {
                "self": "/api/v1/folders/1"
              }
            },
            "contact": {
              "data": {
                "id": "2",
                "type": "contacts"
              }
            }
          },
          "links": {
            "self": "/api/v1/projects/1"
          },
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          }
        },
        {
          "id": "3",
          "type": "projects",
          "attributes": {
            "name": "Test project 3",
            "description": "Test description"
          },
          "relationships": {
            "project-status": {
              "data": {
                "id": "1",
                "type": "project-statuses"
              }
            },
            "main-responsable": {
              "data": null
            },
            "folder": {
              "data": {
                "id": "5",
                "type": "folders"
              },
              "links": {
                "self": "/api/v1/folders/5"
              }
            },
            "contact": {
              "data": null
            }
          },
          "links": {
            "self": "/api/v1/projects/3"
          },
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          }
        },
        {
          "id": "4",
          "type": "projects",
          "attributes": {
            "name": "Test project 4",
            "description": "Test description"
          },
          "relationships": {
            "project-status": {
              "data": {
                "id": "1",
                "type": "project-statuses"
              }
            },
            "main-responsable": {
              "data": null
            },
            "folder": {
              "data": {
                "id": "6",
                "type": "folders"
              },
              "links": {
                "self": "/api/v1/folders/6"
              }
            },
            "contact": {
              "data": null
            }
          },
          "links": {
            "self": "/api/v1/projects/4"
          },
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          }
        },
        {
          "id": "5",
          "type": "projects",
          "attributes": {
            "name": "Test project 5",
            "description": "Test description"
          },
          "relationships": {
            "project-status": {
              "data": {
                "id": "1",
                "type": "project-statuses"
              }
            },
            "main-responsable": {
              "data": null
            },
            "folder": {
              "data": {
                "id": "7",
                "type": "folders"
              },
              "links": {
                "self": "/api/v1/folders/7"
              }
            },
            "contact": {
              "data": null
            }
          },
          "links": {
            "self": "/api/v1/projects/5"
          },
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          }
        },
        {
          "id": "6",
          "type": "projects",
          "attributes": {
            "name": "Test project 6",
            "description": "Test description"
          },
          "relationships": {
            "project-status": {
              "data": {
                "id": "1",
                "type": "project-statuses"
              }
            },
            "main-responsable": {
              "data": null
            },
            "folder": {
              "data": {
                "id": "8",
                "type": "folders"
              },
              "links": {
                "self": "/api/v1/folders/8"
              }
            },
            "contact": {
              "data": null
            }
          },
          "links": {
            "self": "/api/v1/projects/6"
          },
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          }
        },
        {
          "id": "7",
          "type": "projects",
          "attributes": {
            "name": "Test project 7",
            "description": "Test description"
          },
          "relationships": {
            "project-status": {
              "data": {
                "id": "1",
                "type": "project-statuses"
              }
            },
            "main-responsable": {
              "data": null
            },
            "folder": {
              "data": {
                "id": "9",
                "type": "folders"
              },
              "links": {
                "self": "/api/v1/folders/9"
              }
            },
            "contact": {
              "data": null
            }
          },
          "links": {
            "self": "/api/v1/projects/7"
          },
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          }
        },
        {
          "id": "8",
          "type": "projects",
          "attributes": {
            "name": "Test project 8",
            "description": "Test description"
          },
          "relationships": {
            "project-status": {
              "data": {
                "id": "1",
                "type": "project-statuses"
              }
            },
            "main-responsable": {
              "data": null
            },
            "folder": {
              "data": {
                "id": "10",
                "type": "folders"
              },
              "links": {
                "self": "/api/v1/folders/10"
              }
            },
            "contact": {
              "data": null
            }
          },
          "links": {
            "self": "/api/v1/projects/8"
          },
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          }
        },
        {
          "id": "9",
          "type": "projects",
          "attributes": {
            "name": "Test project 9",
            "description": "Test description"
          },
          "relationships": {
            "project-status": {
              "data": {
                "id": "1",
                "type": "project-statuses"
              }
            },
            "main-responsable": {
              "data": null
            },
            "folder": {
              "data": {
                "id": "11",
                "type": "folders"
              },
              "links": {
                "self": "/api/v1/folders/11"
              }
            },
            "contact": {
              "data": null
            }
          },
          "links": {
            "self": "/api/v1/projects/9"
          },
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          }
        },
        {
          "id": "10",
          "type": "projects",
          "attributes": {
            "name": "Test project 10",
            "description": "Test description"
          },
          "relationships": {
            "project-status": {
              "data": {
                "id": "1",
                "type": "project-statuses"
              }
            },
            "main-responsable": {
              "data": null
            },
            "folder": {
              "data": {
                "id": "12",
                "type": "folders"
              },
              "links": {
                "self": "/api/v1/folders/12"
              }
            },
            "contact": {
              "data": null
            }
          },
          "links": {
            "self": "/api/v1/projects/10"
          },
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          }
        },
        {
          "id": "11",
          "type": "projects",
          "attributes": {
            "name": "Test project 11",
            "description": "Test description"
          },
          "relationships": {
            "project-status": {
              "data": {
                "id": "1",
                "type": "project-statuses"
              }
            },
            "main-responsable": {
              "data": null
            },
            "folder": {
              "data": {
                "id": "13",
                "type": "folders"
              },
              "links": {
                "self": "/api/v1/folders/13"
              }
            },
            "contact": {
              "data": null
            }
          },
          "links": {
            "self": "/api/v1/projects/11"
          },
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          }
        },
        {
          "id": "12",
          "type": "projects",
          "attributes": {
            "name": "Test project 12",
            "description": "Test description"
          },
          "relationships": {
            "project-status": {
              "data": {
                "id": "1",
                "type": "project-statuses"
              }
            },
            "main-responsable": {
              "data": null
            },
            "folder": {
              "data": {
                "id": "14",
                "type": "folders"
              },
              "links": {
                "self": "/api/v1/folders/14"
              }
            },
            "contact": {
              "data": null
            }
          },
          "links": {
            "self": "/api/v1/projects/12"
          },
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          }
        },
        {
          "id": "13",
          "type": "projects",
          "attributes": {
            "name": "Test project 13",
            "description": "Test description"
          },
          "relationships": {
            "project-status": {
              "data": {
                "id": "1",
                "type": "project-statuses"
              }
            },
            "main-responsable": {
              "data": null
            },
            "folder": {
              "data": {
                "id": "15",
                "type": "folders"
              },
              "links": {
                "self": "/api/v1/folders/15"
              }
            },
            "contact": {
              "data": null
            }
          },
          "links": {
            "self": "/api/v1/projects/13"
          },
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          }
        },
        {
          "id": "14",
          "type": "projects",
          "attributes": {
            "name": "Test project 14",
            "description": "Test description"
          },
          "relationships": {
            "project-status": {
              "data": {
                "id": "1",
                "type": "project-statuses"
              }
            },
            "main-responsable": {
              "data": null
            },
            "folder": {
              "data": {
                "id": "16",
                "type": "folders"
              },
              "links": {
                "self": "/api/v1/folders/16"
              }
            },
            "contact": {
              "data": null
            }
          },
          "links": {
            "self": "/api/v1/projects/14"
          },
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          }
        },
        {
          "id": "15",
          "type": "projects",
          "attributes": {
            "name": "Test project 15",
            "description": "Test description"
          },
          "relationships": {
            "project-status": {
              "data": {
                "id": "1",
                "type": "project-statuses"
              }
            },
            "main-responsable": {
              "data": null
            },
            "folder": {
              "data": {
                "id": "17",
                "type": "folders"
              },
              "links": {
                "self": "/api/v1/folders/17"
              }
            },
            "contact": {
              "data": null
            }
          },
          "links": {
            "self": "/api/v1/projects/15"
          },
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          }
        },
        {
          "id": "16",
          "type": "projects",
          "attributes": {
            "name": "Test project 16",
            "description": "Test description"
          },
          "relationships": {
            "project-status": {
              "data": {
                "id": "1",
                "type": "project-statuses"
              }
            },
            "main-responsable": {
              "data": null
            },
            "folder": {
              "data": {
                "id": "18",
                "type": "folders"
              },
              "links": {
                "self": "/api/v1/folders/18"
              }
            },
            "contact": {
              "data": null
            }
          },
          "links": {
            "self": "/api/v1/projects/16"
          },
          "meta": {
            "permissions": {
              "update": true,
              "destroy": true
            }
          }
        }
      ],
      "links": {
        "next": "/api/v1/board_lists/1/issues?more_id=16"
      }
    }
    """
