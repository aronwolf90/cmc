Feature: Archive document

@javascript
Scenario: Create document
  Given The app contain seed data
  And I am signed in
  When I click on link "Archive"
  And I click on link "New document"
  And I enter "document name" into input named "Name:"
  And I enter enter a file into input named "File:"
  And select "folder 1" from select box "Folder:"
  And I click on submit
  Then the element "#side-body" contain the text "document name"

@javascript
Scenario: Update document
  Given The app contain seed data
  And I am signed in
  When I click on link "Archive"
  And I click on ".document .fa-edit"
  And I enter "new document name" into input named "Name:"
  And I click on submit
  Then the element "#side-body" contain the text "new document name"
