Feature: Project documents

@javascript
Scenario: Create document
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Projects"
  And I click on link "Test project"
  And I click on link "Documents"
  And I click on link "New document"
  And I enter "document name" into input named "Name:"
  And I enter enter a file into input named "File:"
  And I click on submit
  Then the element "#side-body" contain the text "document name"

@javascript
Scenario: Create document
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Projects"
  And I click on link "Test project"
  And I click on link "Documents"
  And I click on ".fa-edit"
  And I enter "new document name" into input named "Name:"
  And I click on submit
  Then the element "#side-body" contain the text "new document name"
