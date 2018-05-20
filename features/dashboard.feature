Feature: Dashboard

@javascript
Scenario: Projects
  Given I have spent time one a project
  And I am signed in
  Then the page contain the text "project"
  And the page contain the text "01:00:00"
