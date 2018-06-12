Feature: Archive document

@javascript
Scenario: Create document
  Given I am signed in
  And a folder exists with name "folder"
  When I click on link "Archive"
  And I click on link "add document"
  And I enter "document name" into input named "data[name]"
  And I enter enter a file into input named "data[file]"
  And select "folder" from select box "data[folder_id]"
  And I click on submit
  Then the element "#side-body" contain the text "document name"

@javascript
Scenario: Update document
  Given I am signed in
  And a document exists with name "document name" exists
  When I click on link "Archive"
  And I click on ".document .fa-edit"
  And I enter "new document name" into input named "data[name]"
  And I click on submit
  Then the element "#side-body" contain the text "new document name"
