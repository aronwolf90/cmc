Feature: Sigen in

Scenario: Sigen in successfully
  Given I am registered
  When I navigate to "/users/sign_in"
  And I enter "aronwolf90@gmail.com" into input named "user_email"
  And I enter "testtest" into input named "user_password"
  And I click on submit
  Then the page contain the text "Signed in successfully."

Scenario: Fail to sigen in
  Given I am not registered
  When I navigate to "/users/sign_in"
  And I enter "aronwolf90@gmail.com" into input named "user_email"
  And I enter "testtest" into input named "user_password"
  And I click on submit
  Then I am on page "/users/sign_in"
