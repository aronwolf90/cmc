Feature: Project board lists

@javascript
Scenario: move project status
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Projects"
  And I click on link "New"
  And I drag "#column-1" to "#column-3"
  Then the element ".column:last-of-type" contain the text "New"
  When I reload the page
  Then the element ".column:last-of-type" contain the text "New"

@javascript
Scenario: move project to other board
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Projects"
  And I click on link "New"
  When I drag "#list-project-2" to "#list-project-1"
  Then the element "#column-1 .list-project:last-of-type" contain the text "Test project 2"
  When I reload the page
  Then the element "#column-1 .list-project:last-of-type" contain the text "Test project 2"
