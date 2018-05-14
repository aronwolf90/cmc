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
