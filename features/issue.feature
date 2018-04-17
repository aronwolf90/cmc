Feature: Issue

@javascript
Scenario: Show issue
  Given an issue with title "issue title 1" and content "issues content" exists
  And I am signed in
  When I click on link "issue title 1"
  Then the element "#side-body" contain the text "issue title 1"
  And the element "#side-body" contain the text "issues content"

@javascript
Scenario: Edit issue
  Given an issue with title "issue title 1" and content "issues content" exists
  And I am signed in
  When I click on link "issue title 1"
  And I click on ".fa-edit"
  And I replace the text "test" from the markdown editor "form .markdown-editor"
  And I click on submit
  Then the element "#side-body" contain the text "test"

