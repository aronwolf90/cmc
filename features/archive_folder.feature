Feature: Archive folder

@javascript
Scenario: Create folder
  Given I am signed in
  When I click on link "Archive"
  And I click on link "add folder"
  And I enter "folder name" into input named "data[name]"
  And I click on submit
  Then the element "#side-body" contain the text "folder name"

@javascript
Scenario: Edit folder
  Given I am signed in
  And a folder exists with name "folder"
  When I click on link "Archive"
  And I click on ".folder .fa-edit"
  And I enter "new folder name" into input named "data[name]"
  And I click on submit
  Then the element "#side-body" contain the text "new folder name"
