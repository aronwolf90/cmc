Feature: Calender

@javascript
Scenario: Create calender
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Calender"
  Then the element "#side-body" contain the text "Today"
