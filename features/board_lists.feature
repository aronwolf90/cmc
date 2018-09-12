Feature: Board lists

@javascript
Scenario: create board list
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
