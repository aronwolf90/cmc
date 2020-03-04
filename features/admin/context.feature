Feature: Context page

@javascript
Scenario: Change config
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Admin"
  And select "London" from select box "Time zone"
  And I check the input named "Global board"
  And I click on submit
  And I reload the page
  Then the page contain the text "London"
  And the input "Global board" is checked
