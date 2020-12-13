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
Scenario: Edit project status
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Projects"
  And I click on link "Archived"
  And I click on ".fa-edit"
  And I enter "Closed" into input named "Name"
  And I click on submit
  Then the page contain the text "Closed"
  And the page does not contain the text "Archived"

@javascript
Scenario: Destroy project status
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Projects"
  And I click on link "Archived"
  And I click on ".fa-trash"
  Then the page does not contain the text "Archived"

@javascript
Scenario: move project status
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Projects"
  Then the page contain the text "Test project 10"
  And the page contain the text "New"
  When I drag "#project-status-1" to "#project-status-3"
  Then the element ".project-status:last-of-type" contain the text "New"
  When I reload the page
  Then the element ".project-status:last-of-type" contain the text "New"
