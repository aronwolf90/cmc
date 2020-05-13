Feature: API: List issue comments

@javascript
Scenario: GET /api/v1/issues/<id>/comments
  Given a test-organization exists and is loaded
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  When I send a GET request to "/api/v1/issues/1/comments"
  Then the response status should be "200"
  And the JSON response should be:
    """
    { 
      "meta": {
        "count": 0
      },
      "data":[], 
      "links":{ 
        "self":"/api/v1/issues/1/comments"
      }
    }
    """
