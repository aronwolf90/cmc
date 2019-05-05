Feature: API: list users

Scenario: Get
  And I am an user with an id of 1
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
 And I send a GET request to "/api/v1/attendance_days?page[number]=15-01-2019"
  Then the JSON response should be:
    """
    {
      "data": [
        {
          "id": "2019-01-15",
          "type": "attendance-days",
          "attributes": {
            "day": "2019-01-15",
            "kind": "normal-day"
          }
        },
        {
          "id": "2019-01-16",
          "type": "attendance-days",
          "attributes": {
            "day": "2019-01-16",
            "kind": "normal-day"
          }
        },
        {
          "id": "2019-01-17",
          "type": "attendance-days",
          "attributes": {
            "day": "2019-01-17",
            "kind": "normal-day"
          }
        },
        {
          "id": "2019-01-18",
          "type": "attendance-days",
          "attributes": {
            "day": "2019-01-18",
            "kind": "normal-day"
          }
        },
        {
          "id": "2019-01-19",
          "type": "attendance-days",
          "attributes": {
            "day": "2019-01-19",
            "kind": "weekend-day"
          }
        },
        {
          "id": "2019-01-20",
          "type": "attendance-days",
          "attributes": {
            "day": "2019-01-20",
            "kind": "weekend-day"
          }
        },
        {
          "id": "2019-01-21",
          "type": "attendance-days",
          "attributes": {
            "day": "2019-01-21",
            "kind": "normal-day"
          }
        },
        {
          "id": "2019-01-22",
          "type": "attendance-days",
          "attributes": {
            "day": "2019-01-22",
            "kind": "normal-day"
          }
        },
        {
          "id": "2019-01-23",
          "type": "attendance-days",
          "attributes": {
            "day": "2019-01-23",
            "kind": "normal-day"
          }
        },
        {
          "id": "2019-01-24",
          "type": "attendance-days",
          "attributes": {
            "day": "2019-01-24",
            "kind": "normal-day"
          }
        },
        {
          "id": "2019-01-25",
          "type": "attendance-days",
          "attributes": {
            "day": "2019-01-25",
            "kind": "normal-day"
          }
        },
        {
          "id": "2019-01-26",
          "type": "attendance-days",
          "attributes": {
            "day": "2019-01-26",
            "kind": "weekend-day"
          }
        },
        {
          "id": "2019-01-27",
          "type": "attendance-days",
          "attributes": {
            "day": "2019-01-27",
            "kind": "weekend-day"
          }
        },
        {
          "id": "2019-01-28",
          "type": "attendance-days",
          "attributes": {
            "day": "2019-01-28",
            "kind": "normal-day"
          }
        }
      ],
      "links": {
        "first": null,
        "last": null,
        "prev": "2019-01-01",
        "next": "2019-01-29"
      }
    }
    """
  And the response status should be "200"
