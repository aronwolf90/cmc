Feature: Project status

@javascript
Scenario: Create project status
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Projects"
  And I click on ".fa-plus"
  And I enter "Test" into input named "Name"
  And I click on submit
  Then the element "#side-body" contain the text "Test"
  And the element ".projects-left-aside" contain the text "Test"

@javascript
Scenario: Destroy project status
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Projects"
  And I click on link "Archived"
  And I click on ".fa-trash"
  Then the page does not contain the text "Archived"
