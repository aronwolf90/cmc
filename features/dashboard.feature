Feature: Dashboard

@javascript
Scenario: Projects
  Given The app contain seed data
  And I am signed in
  Then the page contain the text "Test project"
  And the page contain the text "00:00:00"
