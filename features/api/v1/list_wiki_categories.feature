Feature: API: list users

@javascript
Scenario: Get
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/wiki_categories"
  Then the JSON response should be:
    """
    { 
      "meta": {
        "count": 3
      },
      "data":[ 
        { 
          "id":"1",
          "type":"wiki-categories",
          "attributes":{ 
            "title":"category 1",
            "root":true
          },
          "relationships":{ 
            "wiki-category":{ 
              "data":null
            },
            "wiki-categories":{ 
              "data":[ 
                { 
                  "id":"2",
                  "type":"wiki-categories"
                },
                { 
                  "id":"3",
                  "type":"wiki-categories"
                }
              ]
            },
            "wiki-pages":{ 
              "data":[ 
    
              ]
            }
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
          "type":"wiki-categories",
          "attributes":{ 
            "title":"subcategory 1",
            "root":false
          },
          "relationships":{ 
            "wiki-category":{ 
              "data":{ 
                "id":"1",
                "type":"wiki-categories"
              }
            },
            "wiki-categories":{ 
              "data":[ 
    
              ]
            },
            "wiki-pages":{ 
              "data":[ 
    
              ]
            }
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
          "type":"wiki-categories",
          "attributes":{ 
            "title":"subcategory 2",
            "root":false
          },
          "relationships":{ 
            "wiki-category":{ 
              "data":{ 
                "id":"1",
                "type":"wiki-categories"
              }
            },
            "wiki-categories":{ 
              "data":[ 
    
              ]
            },
            "wiki-pages":{ 
              "data":[ 
                { 
                  "id":"1",
                  "type":"wiki-pages"
                }
              ]
            }
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
        "self":"/api/v1/wiki_categories"
      }
    }
    """
  And the response status should be "200"
