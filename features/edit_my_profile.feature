Feature: Edit my profile

@javascript
Scenario: Change firstname
  Given I am signed in
  When I click on ".navbar-nav img"
  And I click on link "Settings"
  And I enter "new user name" into input named "data_firstname"
  And I click on submit
  Then the page contain the text "user has been updated"
  And I reload the page
  Then the input "data_firstname" has the value "new user name"
