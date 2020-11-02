Feature: Tickets -> board list

@javascript
Scenario: Change board list
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Tickets"
  And I click on link "Test issue 2"
  And I click on "#right-aside-board-list input"
  And I click on "#right-aside-board-list .item" with "Closed"
  And I reload the page
  Then the element "#right-aside-board-list .text" contain the text "Closed"
