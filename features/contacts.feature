Feature: Contacts

@javascript
Scenario: Manage contact
  Given a test-organization exists
  And I am signed in (multitenant)
  # Create
  When I click on link "Contact"
  And I click on link "New contact"
  And I enter "New person" into input named "Name:"
  And I click on submit
  Then the element "#side-body" contain the text "New person"
  # Update
  When I reload the page
  And I click on link "Contact"
  And I click on link "New person"
  And I click on ".fa-edit"
  Then the input "input-name" has the value "New person" 
  When I enter "Updated New person" into input named "input-name"
  And I click on submit
  Then the element "#side-body" contain the text "Updated New person"
  When I reload the page
  # Destroy
  And I click on link "Contact"
  And I click on link "Updated New person"
  And I click on ".fa-trash"
  And I click on button "YES"
  Then the element "#side-body" does not contain the text "Updated New person"
  When I reload the page
  When I click on link "Contact"
  Then the element "#side-body" does not contain the text "Updated New person"
