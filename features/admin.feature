Feature: Admin

@javascript
Scenario: Change time zone 
  Given The app contain seed data
  And I am signed in
  When I click on link "Admin"
  And select "London" from select box "data[time_zone]"
  And I click on submit
  And I reload the page
  Then the page contain the text "London"
