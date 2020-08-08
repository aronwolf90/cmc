Feature: Archive folder

@javascript
Scenario: Create successfully a new organization
  Given no "test-organization" exists
  And the mailbox is empty"
  When I navigate to "/registrations/new"
  And I enter "test-organization" into input named "data[name]"
  And select "Berlin" from select box "data[time_zone]"
  And I enter "Firstname" into input named "data[firstname]"
  And I enter "Lastname" into input named "data[lastname]"
  And I enter "test@email.lvh" into input named "data[email]"
  And I enter "password123" into input named "data[password]"
  And I enter "password123" into input named "data[confirmation_password]"
  And I check the input named "data[terms_service]"
  And I click on submit
  And I enter "test@email.lvh" into input named "user[email]"
  And I enter "password123" into input named "user[password]"
  And I click on submit
  Then the element "body" contain the text "Dashboard"
  And a email was sent

@javascript
Scenario: Can not register a blacklisted name
  Given no "test-organization" exists
  When I navigate to "/registrations/new"
  And I enter "about" into input named "data[name]"
  And select "Berlin" from select box "data[time_zone]"
  And I enter "Firstname" into input named "data[firstname]"
  And I enter "Lastname" into input named "data[lastname]"
  And I enter "test@email.lvh" into input named "data[email]"
  And I enter "password123" into input named "data[password]"
  And I enter "password123" into input named "data[confirmation_password]"
  And I check the input named "data[terms_service]"
  And I click on submit
  Then the page contain the text "Use a different name"
