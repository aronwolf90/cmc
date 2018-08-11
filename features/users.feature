Feature: Users

Scenario: List user
  Given I am signed in
  When I click on link "Users"
  Then the element "#side-body" contain the text "aron"

Scenario: Create user
  Given I am signed in
  When I click on link "Users"
  And I click on link "New user"
  And I enter "firstname" into input named "data_firstname"
  And I enter "lastname" into input named "data_lastname"
  And I enter "test@email.com" into input named "data_email"
  And I enter "password" into input named "data_password"
  And I enter "password" into input named "data_password_confirmation"
  And I click on submit
  Then the element "#side-body" contain the text "firstname"


@javascript
Scenario: Edit user
  Given I am signed in
  When I click on ".navbar-nav img"
  And I click on link "Users"
  And I click on ".fa-edit"
  And I enter "new firstname" into input named "data_firstname"
  And I click on submit
  Then the page contain the text "User has been updated"
  And I reload the page
  Then the input "data_firstname" has the value "new firstname"
