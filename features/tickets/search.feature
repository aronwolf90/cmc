Feature: Search a ticket on the ticket board

@javascript
Scenario: Find one ticket
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Tickets"
  And I enter "Issue 1" into input "[placeholder='Search']"
  And I click on ".search-select-item"
  Then the page contain the text "description for the test issue"
