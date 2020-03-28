Feature: Projects

@javascript
Scenario: Create project
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Projects"
  And I click on link "New project"
  And I enter "project title" into input named "Name"
  And I click on submit
  Then the element "#side-body" contain the text "project title"

@javascript
Scenario: Update project
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Projects"
  And I click on ".fa-edit"
  And I enter "project title new" into input named "Name"
  And I click on submit
  Then the element "#side-body" contain the text "project title new"

@javascript
Scenario: Show project
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Projects"
  And I click on link "Test project 2"

@javascript
Scenario: Change projekt on board
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Issues"
  And select "Test project 2" from select box "project-select"
  Then the page contain the text "Test project 2 open"

@javascript
Scenario: Comment
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Projects"
  And I click on link "Test project 2"
  When I replace the text "test comment" from the markdown editor ".comments .markdown-editor"
  And I click on ".comments .btn"
  Then the element ".comment" contain the text "test comment"
  When I reload the page
  Then the element ".comment" contain the text "test comment"
