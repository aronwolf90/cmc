Feature: Admin

@javascript
Scenario: Change time zone 
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Admin"
  And select "London" from select box "data[time_zone]"
  And I click on submit
  And I reload the page
  Then the page contain the text "London"
