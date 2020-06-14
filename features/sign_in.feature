Feature: Sigen in

@javascript
Scenario: Sigen in successfully
  Given a test-organization exists
  When I navigate to "/users/sign_in"
  And I enter "test-organization" into input named "organization"
  And I click on submit
  And I enter "admin@lvh.me" into input named "user_email"
  And I enter "admin@lvh.me" into input named "user_email"
  And I enter "testtest" into input named "user_password"
  And I click on submit
  Then I am on page "/administration"

@javascript
Scenario: Fail to sigen in
  Given a test-organization exists
  When I navigate to "/users/sign_in"
  And I enter "test-organization" into input named "organization"
  And I click on submit
  And I enter "nouser@lvh.me" into input named "user_email"
  And I enter "testtest" into input named "user_password"
  And I click on submit
  Then I am on page "/users/sign_in"
