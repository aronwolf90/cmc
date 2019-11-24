Feature: API: list users

Scenario: Get
  Given The app contain seed data
  And I set headers:
   | Authorization | Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjF9.ClWbiKD35AyiLHuBiDeCTeDwseNvX4WxFlZqdar37TU |
   | Content-Type | application/vnd.api+json |
  And I send a GET request to "/api/v1/invoices"
  Then the response status should be "200"
  And the JSON response should be:
    """
    {
      "data": [{
        "id": "in_1FbueoLeD4GoxaIE6rVfYns7",
        "type": "invoices",
        "attributes": {
          "created-at": "2019-11-06T19:59:10Z",
          "amount-paid": 58668,
          "amount-due": 58668,
          "amount-remaining": 0,
          "pdf": "https://pay.stripe.com/invoice/invst_9KtFtihugeF8KkYEfFEJltHcg7/pdf"
        }
      }, {
        "id": "in_1FQfsiLeD4GoxaIEtKwWfNRT",
        "type": "invoices",
        "attributes": {
        "created-at": "2019-10-06T19:59:04Z",
          "amount-remaining": 0,
          "amount-paid": 20000,
          "amount-due": 20000,
          "pdf": "https://pay.stripe.com/invoice/invst_7sNZM2hdIJubqnCNFhmJ4F5WeF/pdf"
        }
      }],
      "links": { "self": "/api/v1/invoices" }
    }
    """
