Feature: Board lists

@javascript
Scenario: create board list
  Given a test-organization exists with global board lists
  And I am signed in (multitenant)
  And I click on link "Issues"
  And I click on ".fa-plus"
  And I enter "board list name" into input named "Name"
  And I click on submit
  And I reload the page
  Then the page contain the text "board list name"

@javascript
Scenario: edit board list
  Given a test-organization exists with global board lists
  And I am signed in (multitenant)
  When I click on link "Issues"
  And I click on ".column:first-of-type .fa-edit"
  And I enter "new board list name" into input named "Name"
  And I click on submit
  And I reload the page
  Then the page contain the text "new board list name"

@javascript
Scenario: change board lists order
  Given a test-organization exists with global board lists
  And I am signed in (multitenant)
  When I click on link "Issues"
  And I drag "#column-1 > .card-header" to "#column-3 > .card-header"
  Then the element ".column:last-of-type" contain the text "Open"
  When I reload the page
  Then the element ".column:last-of-type" contain the text "Open"

@javascript
Scenario: change issues order
  Given a test-organization exists with global board lists
  And I am signed in (multitenant)
  When I click on link "Issues"
  And I drag "#list-issue-4" to "#list-issue-1"
  Then the element "#column-1 .list-issue:last-of-type" contain the text "Test issue 4"
  When I reload the page
  Then the element "#column-1 .list-issue:last-of-type" contain the text "Test issue 4"

@javascript
Scenario: move issue to other board
  Given a test-organization exists with global board lists
  And I am signed in (multitenant)
  When I click on link "Issues"
  Then the element "#side-body" contain the text "Open"
  When I drag "#list-issue-4" to "#list-issue-5"
  Then the element "#column-2 .list-issue:last-of-type" contain the text "Test issue 4"
  When I reload the page
  Then the element "#column-2 .list-issue:last-of-type" contain the text "Test issue 4"

@javascript
Scenario: change selected project
  Given a test-organization exists with global board lists
  And I am signed in (multitenant)
  When I click on link "Issues"
  And select "Test project 2" from select box "project-select"
  Then the element "#side-body" does not contain the text "Test issue 1"
