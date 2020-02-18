Feature: Dashboard

@javascript
Scenario: Projects
  Given a test-organization exists
  And I am signed in (multitenant)
  Then the page contain the text "Test project"
  And the page contain the text "00:00:00"
