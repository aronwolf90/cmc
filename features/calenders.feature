Feature: Calendar

@javascript
Scenario: Create calender
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Calendar"
  Then the element "#side-body" contain the text "Today"
