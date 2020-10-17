Feature: Issue

@javascript
Scenario: Create Issue
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Tickets"
  And I click on ".issues-board-body .fa-plus"
  And I enter "issue name" into input named "Title"
  And I click on submit
  And I reload the page
  Then the page contain the text "issue name"

@javascript
Scenario: Create Issue on global board
  Given a test-organization exists with global board lists
  And I am signed in (multitenant)
  When I click on link "Tickets"
  And I click on ".issues-board-body .fa-plus"
  And I enter "issue name" into input named "Title"
  And I click on submit
  And I reload the page
  Then the page contain the text "issue name"

@javascript
Scenario: Create Issue on global board when all is selected
  Given a test-organization exists with global board lists
  And I am signed in (multitenant)
  When I click on link "Tickets"
  And I click on "#project-select" 
  And I click on "[role='option']" with "All"
  And I sleep "1" seconds
  And I click on ".issues-board-body .fa-plus"
  And I enter "issue name" into input named "Title"
  And I click on "#project-select" 
  And I click on "[role='option']" with "Test project 2"
  And I click on submit
  Then the page contain the text "issue name"
  When I reload the page
  Then the page contain the text "issue name"

@javascript
Scenario: Show issue
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Test issue 1"
  Then the element "#side-body" contain the text "Test issue 1"
  And the element "#side-body" contain the text "description"

@javascript
Scenario: Edit issue with all fields changed
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Test issue 1"
  And I click on ".fa-edit"
  And I enter "new issue name" into input named "name-input"
  And I replace the text "new description" from the markdown editor "form .markdown-editor"
  And I click on ".show-body [type='submit']"
  Then the element "#side-body" contain the text "new issue name"
  And the element "#side-body" contain the text "new description"

@javascript
Scenario: Edit issue with all not necessary fields removed
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Test issue 1"
  And I click on ".fa-edit"
  And I replace the text "" from the markdown editor "form .markdown-editor"
  And I click on ".show-body [type='submit']"
  Then the element "#side-body" does not contain the text "description for the test issue"

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
  When I click on "#assigen input"
  And I click on "#assigen .item:nth-child(2)"
  Then the element "#assigen .text" contain the text "user2"
  When I reload the page
  Then the element "#assigen .text" contain the text "user2"
  When I click on link "Tickets"
  Then the page contain the element "[alt='user2 simson']"

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

@javascript
Scenario: Comment
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Test issue 1"
  When I replace the text "test comment" from the markdown editor ".comments .markdown-editor"
  And I click on ".comments .btn"
  Then the element ".comment" contain the text "test comment"
  When I reload the page
  Then the element ".comment" contain the text "test comment"
