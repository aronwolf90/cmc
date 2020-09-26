Feature: Labels

@javascript
Scenario: Create and update a label
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Tickets"
  And I click on link "Test issue 1"
  And I click on ".labels .fa-plus"
  And I enter "Test label" into input named "Name"
  And I click on button "Create label"
  And I reload the page
  And I click on link "Labels"
  Then the page contain the text "Test label"
  And I click on "button .fa-edit"
  And I enter "Test label updated" into input named "Name"
  And I click on button "Update label"
  And I reload the page
  And I click on link "Labels"
  Then the page contain the text "Test label updated"

@javascript
Scenario: Assign a label to a ticket
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Tickets"
  And I click on link "Test issue 2"
  And I click on ".labels input"
  And I click on ".labels li" with "Important"
  And I click on link "Tickets"
  Then the element "#list-issue-2" contain the text "Important"
