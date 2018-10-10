Feature: Users

Scenario: List user
  Given The app contain seed data
  And I am signed in
  When I click on link "Users"
  Then the element "#side-body" contain the text "Aron"

Scenario: Create user
  Given I am signed in
  When I click on link "Users"
  And I click on link "New user"
  And I enter "firstname" into input named "data_firstname"
  And I enter "lastname" into input named "data_lastname"
  And I enter "test@email.com" into input named "data_email"
  And select "Admin" from select box "data_type"
  And I enter "password" into input named "data_password"
  And I enter "password" into input named "data_password_confirmation"
  And I click on submit
  Then the element "#side-body" contain the text "firstname"


@javascript
Scenario: Edit user
  Given The app contain seed data
  And I am signed in
  When I click on ".navbar-nav img"
  And I click on link "Users"
  And I click on link "user2 simson"
  And I enter "new firstname" into input named "data_firstname"
  And I click on submit
  Then the page contain the text "user has been updated"
  And I reload the page
  And the input "data_firstname" has the value "new firstname"

@javascript
Scenario: Edit user
  Given The app contain seed data
  And I am signed in
  When I click on link "Users"
  And I click on link "user3 Herrera"
  And I click on link "Configuration"
  And I click on link "Destroy"
  Then the page contain the text "user has been destroyed"
  And the page does not contain the text "user3 Herrera"
