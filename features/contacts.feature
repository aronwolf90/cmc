Feature: Projects

@javascript
Scenario: Create contact
  Given The app contain seed data
  And I am signed in
  When I click on link "Contacts"
  And I click on link "New contact"
  And I enter "New person" into input named "input-name"
  And I click on submit
  Then the element "#side-body" contain the text "New person"

@javascript
Scenario: Update contact
  Given The app contain seed data
  And I am signed in
  When I click on link "Contacts"
  And I click on link "Clara"
  And I click on ".fa-edit"
  Then the input "input-name" has the value "Clara" 
  When I enter "Updated Clara" into input named "input-name"
  And I click on submit
  Then the element "#side-body" contain the text "Updated Clara"
