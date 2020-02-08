Feature: API: List current user notifications

Scenario: GET /api/v1/notifications
  Given The app contain seed data
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a GET request to "/api/v1/notifications"
  Then the JSON response should be:
    """
    { 
      "data":[ 
        { 
          "id":"1",
          "type":"notifications",
          "attributes":{ 
            "subject":"Nofification 1",
            "body":"body 1"
          }
        },
        { 
          "id":"2",
          "type":"notifications",
          "attributes":{ 
            "subject":"Nofification 2",
            "body":"body 2"
          }
        },
        { 
          "id":"3",
          "type":"notifications",
          "attributes":{ 
            "subject":"Nofification 3",
            "body":"body 3"
          }
        },
        { 
          "id":"4",
          "type":"notifications",
          "attributes":{ 
            "subject":"Nofification 4",
            "body":"body 4"
          }
        },
        { 
          "id":"5",
          "type":"notifications",
          "attributes":{ 
            "subject":"Nofification 5",
            "body":"body 5"
          }
        },
        { 
          "id":"6",
          "type":"notifications",
          "attributes":{ 
            "subject":"Nofification 6",
            "body":"body 6"
          }
        },
        { 
          "id":"7",
          "type":"notifications",
          "attributes":{ 
            "subject":"Nofification 7",
            "body":"body 7"
          }
        },
        { 
          "id":"8",
          "type":"notifications",
          "attributes":{ 
            "subject":"Nofification 8",
            "body":"body 8"
          }
        },
        { 
          "id":"9",
          "type":"notifications",
          "attributes":{ 
            "subject":"Nofification 9",
            "body":"body 9"
          }
        },
        { 
          "id":"10",
          "type":"notifications",
          "attributes":{ 
            "subject":"Nofification 10",
            "body":"body 10"
          }
        },
        { 
          "id":"11",
          "type":"notifications",
          "attributes":{ 
            "subject":"Nofification 11",
            "body":"body 11"
          }
        },
        { 
          "id":"12",
          "type":"notifications",
          "attributes":{ 
            "subject":"Nofification 12",
            "body":"body 12"
          }
        },
        { 
          "id":"13",
          "type":"notifications",
          "attributes":{ 
            "subject":"Nofification 13",
            "body":"body 13"
          }
        },
        { 
          "id":"14",
          "type":"notifications",
          "attributes":{ 
            "subject":"Nofification 14",
            "body":"body 14"
          }
        },
        { 
          "id":"15",
          "type":"notifications",
          "attributes":{ 
            "subject":"Nofification 15",
            "body":"body 15"
          }
        }
      ],
			"links": { "next": "/api/v1/notifications?more_id=15" }
    }
    """
  And the response status should be "200"

Scenario: GET /api/v1/notifications
  Given The app contain seed data
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a GET request to "/api/v1/notifications?more_id=15"
  Then the JSON response should be:
    """
    { 
      "data":[ 
        { 
          "id":"16",
          "type":"notifications",
          "attributes":{ 
            "subject":"Nofification 16",
            "body":"body 16"
          }
        },
				{
				  "id": "17",
					"type": "notifications",
					"attributes": {
					  "subject": "Nofification 17",
						"body": "body 17"
					}
				}
			],
			"links": { "next": null }
		}
		"""
