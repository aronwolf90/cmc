Feature: Admin area

@javascript
Scenario: List organization
  Given a test-organization exists
  When I navigate admin_area
  Then the element "#side-body" contain the text "test-organization"
