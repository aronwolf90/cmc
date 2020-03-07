Feature: Issue

@javascript
Scenario: Create Issue
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Issues"
  And I click on ".issues-board-body .fa-plus"
  And I enter "issue name" into input named "Title"
  And I click on submit
  And I reload the page
  Then the page contain the text "issue name"

@javascript
Scenario: Create Issue on global board
  Given a test-organization exists with global board lists
  And I am signed in (multitenant)
  When I click on link "Issues"
  And I click on ".issues-board-body .fa-plus"
  And I enter "issue name" into input named "Title"
  And I click on submit
  And I reload the page
  Then the page contain the text "issue name"

@javascript
Scenario: Show issue
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Test issue 1"
  Then the element "#side-body" contain the text "Test issue 1"
  And the element "#side-body" contain the text "description"

@javascript
Scenario: Edit issue
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Test issue 1"
  And I click on ".fa-edit"
  And I replace the text "test" from the markdown editor "form .markdown-editor"
  And I click on ".show-body [type='submit']"
  Then the element "#side-body" contain the text "test"

@javascript
Scenario: Delete issue
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Test issue 1"
  And I click on ".fa-trash"
  Then the element "#side-body" contain the text "Backlog"

@javascript
Scenario: Change user
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Test issue 1"
  And I click on "#assigen .text"
  Then the element "#assigen .text" does not contain the text "user2"
  And I click on "#assigen input"
  And I click on "#assigen .item:nth-child(2)"
  Then the element "#assigen .text" contain the text "user2"
  And I reload the page
  Then the element "#assigen .text" contain the text "user2"

@javascript
Scenario: Change complexity
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Test issue 1"
  And I click on "#complexity .text"
  And I click on "#complexity .item:nth-child(2)"
  Then the element "#complexity .text" contain the text "0.5"
  And I reload the page
  Then the element "#complexity .text" contain the text "0.5"
