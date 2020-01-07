Feature: Users

@javascript
Scenario: List user
  Given The app contain seed data
  And I am signed in
  When I click on link "Users"
  Then the element "#side-body" contain the text "Aron"

@javascript
Scenario: Create user
  Given I am signed in
  When I click on link "Users"
  And I click on link "New user"
  And I enter "firstname" into input named "Firstname"
  And I enter "lastname" into input named "Lastname"
  And I enter "test@email.com" into input named "E-Mail"
  And select "Admin" from select box "Type"
  And I click on submit
  Then the element "#side-body" contain the text "firstname"

@javascript
Scenario: Create user on no premium when 6 users exist
  Given Multi tenant is enabled
  And The app contain seed data
  And set "test-organization" as current organization
  And Organization is not premium
  And 5 additional users exist
  And I am signed in (multitenant)
  When I click on link "Users"
  And I click on button "New user"
  And I click on link "Continue"
  And I enter "firstname" into input named "Firstname"
  And I enter "lastname" into input named "Lastname"
  And I enter "test@email.com" into input named "E-Mail"
  And select "Admin" from select box "Type"
  And I click on submit
  Then the element "#side-body" contain the text "firstname"

@javascript
Scenario: Create user on premium when 6 users exist
  Given Multi tenant is enabled
  And The app contain seed data
  And set "test-organization" as current organization
  And 5 additional users exist
  And I am signed in (multitenant)
  When I click on link "Users"
  And I click on button "New user"
  And I click on link "Continue"
  And I enter "firstname" into input named "Firstname"
  And I enter "lastname" into input named "Lastname"
  And I enter "test@email.com" into input named "E-Mail"
  And select "Admin" from select box "Type"
  And I click on submit
  Then the element "#side-body" contain the text "firstname"
  When I click on link "Admin"
  And I click on link "Payment"
  Then the element "#side-body" contain the text "5€/month"


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
Scenario: Destroy user
  Given The app contain seed data
  And I am signed in
  When I click on link "Users"
  And I click on link "user3 Herrera"
  And I click on link "Configuration"
  And I click on link "Destroy"
  Then the page contain the text "user has been destroyed"
  And the page does not contain the text "user3 Herrera"
