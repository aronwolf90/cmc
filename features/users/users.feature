Feature: Users

@javascript
Scenario: List user
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Users"
  Then the element "#side-body" contain the text "Aron"

@javascript
Scenario: Create user
  Given a test-organization exists
  And I am signed in (multitenant)
  And the mailbox is empty"
  When I click on link "Users"
  And I click on link "New user"
  And I enter "firstname" into input named "Firstname"
  And I enter "lastname" into input named "Lastname"
  And I enter "test@email.com" into input named "E-Mail"
  And select "Admin" from select box "Type"
  And I click on submit
  Then the element "#side-body" contain the text "firstname"
  And a email was sent

  #@javascript
  #Scenario: Create user on no premium when 6 users exist
  #  Given a test-organization exists
  #  And set "test-organization" as current organization
  #  And Organization is not premium
  #  And 5 additional users exist
  #  And I am signed in (multitenant)
  #  When I click on link "Users"
  #  And I click on button "New user"
  #  And I click on link "Continue"
  #  And I enter "firstname" into input named "Firstname"
  #  And I enter "lastname" into input named "Lastname"
  #  And I enter "test@email.com" into input named "E-Mail"
  #  And select "Admin" from select box "Type"
  #  And I click on submit
  #  Then the element "#side-body" contain the text "firstname"
  #
  #@javascript
  #Scenario: Create user on premium when 6 users exist
  #  Given a premium test-organization exists
  #  And set "test-organization" as current organization
  #  And 5 additional users exist
  #  And I am signed in (multitenant)
  #  When I click on link "Users"
  #  And I click on link "New user"
  #  And I enter "firstname" into input named "Firstname"
  #  And I enter "lastname" into input named "Lastname"
  #  And I enter "test@email.com" into input named "E-Mail"
  #  And select "Admin" from select box "Type"
  #  And I click on submit
  #  Then the element "#side-body" contain the text "firstname"
  #  When I click on link "Admin"
  #  And I click on link "Payment"
  #  Then the element "#side-body" contain the text "20€"

@javascript
Scenario: Edit user
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on ".navbar-nav img"
  And I click on link "Users"
  And I click on link "user2 simson"
  And I enter "new firstname" into input named "Firstname"
  And I click on submit
  Then the input "Firstname" has the value "new firstname"
  When I reload the page
  Then the input "Firstname" has the value "new firstname"

@javascript
Scenario: Change employee to admin
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on ".navbar-nav img"
  And I click on link "Users"
  And I click on link "user2 simson"
  And I click on link "Configuration"
  And I click on submit

@javascript
Scenario: Inactivate user
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on ".navbar-nav img"
  And I click on link "Users"
  And I click on link "user2 simson"
  And I click on link "Configuration"
  And I click on "[for='input-active']"
  And I click on submit
  And I click on link "Users"
  Then the page contain the text "Disabled"

  #@javascript
  #Scenario: Destroy user
  #  Given a test-organization exists
  #  And I am signed in (multitenant)
  #  When I click on link "Users"
  #  And I click on link "user3 Herrera"
  #  And I click on link "Configuration"
  #  And I click on button "Destroy"
  #  Then the page does not contain the text "user3 Herrera"
  #  And the page contain the text "New user"
