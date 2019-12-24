Feature: Board lists

@javascript
Scenario: create board list
  Given The app contain seed data
  Given I am signed in
  And I click on link "Issues"
  And I click on ".fa-plus"
  And I enter "board list name" into input named "data_name"
  And I click on submit
  And I reload the page
  Then the page contain the text "board list name"

@javascript
Scenario: edit board list
  Given The app contain seed data
  And I am signed in
  When I click on link "Issues"
  And I click on ".column:first-of-type .fa-edit"
  And I enter "new board list name" into input named "data_name"
  And I click on submit
  And I reload the page
  Then the page contain the text "new board list name"

@javascript
Scenario: change board lists order
  Given The app contain seed data
  And I am signed in
  When I click on link "Issues"
  And I drag "#column-1 > .card-header" to "#column-3 > .card-header"
  Then the element ".column:last-of-type" contain the text "Backlog"
  When I reload the page
  Then the element ".column:last-of-type" contain the text "Backlog"

@javascript
Scenario: change issues order
  Given The app contain seed data
  And I am signed in
  When I click on link "Issues"
  And I drag "#list-issue-4" to "#list-issue-1"
  Then the element "#column-1 .list-issue:last-of-type" contain the text "Test issue 4"
  When I reload the page
  Then the element "#column-1 .list-issue:last-of-type" contain the text "Test issue 4"

@javascript
Scenario: move issue to other board
  Given The app contain seed data
  And I am signed in
  When I click on link "Issues"
  Then the element "#side-body" contain the text "Backlog"
  When I drag "#list-issue-4" to "#list-issue-5"
  Then the element "#column-2 .list-issue:last-of-type" contain the text "Test issue 4"
  When I reload the page
  Then the element "#column-2 .list-issue:last-of-type" contain the text "Test issue 4"
