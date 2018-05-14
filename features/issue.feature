Feature: Issue

@javascript
Scenario: create board list
  Given an issue with title "issue title 1" and content "issues content" exists
  And I am signed in
  And I click on link "Issues"
  And I click on ".issues-board-body .fa-plus"
  And I enter "issue name" into input named "data_title"
  And I enter "description" into input named "data_description"
  And I click on submit
  And I reload the page
  Then the page contain the text "issue name"

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

@javascript
Scenario: Change user
  Given an issue with title "issue title 1" and content "issues content" exists
  And I am signed in
  When I click on link "issue title 1"
  And I click on "#assigen .text"
  Then the element "#assigen .text" does not contain the text "aron"
  And I click on "#assigen .item:nth-child(1)"
  Then the element "#assigen .text" contain the text "aron"
  And I reload the page
  Then the element "#assigen .text" contain the text "aron"

@javascript
Scenario: Change complexity
  Given an issue with title "issue title 1" and content "issues content" exists
  And I am signed in
  When I click on link "issue title 1"
  And I click on "#complexity .text"
  And I click on "#complexity .item:nth-child(2)"
  Then the element "#complexity .text" contain the text "0.5"
  And I reload the page
  Then the element "#complexity .text" contain the text "0.5"
