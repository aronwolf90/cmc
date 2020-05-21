Feature: Projects

@javascript
Scenario: Create project
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Projects"
  And I click on link "New project"
  And I enter "project title" into input named "Name"
  And I click on submit
  And I click on "[aria-label='Go to last page']"
  Then the element "#side-body" contain the text "project title"

@javascript
Scenario: Update project
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Projects"
  And I click on ".fa-edit"
  And I enter "project title new" into input named "name-input"
  And I click on submit
  Then the element "#side-body" contain the text "project title new"

@javascript
Scenario: Show project
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Projects"
  And I click on link "Test project 2"

@javascript
Scenario: Comment
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Projects"
  And I click on link "Test project 2"
  When I replace the text "test comment" from the markdown editor ".comments .markdown-editor"
  And I click on ".comments .btn"
  Then the element ".comment" contain the text "test comment"
  When I reload the page
  Then the element ".comment" contain the text "test comment"

@javascript
Scenario: Edit contact inputs
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Projects"
  And I click on link "Test project"
  And I click on "#contact-name .fa-edit"
  And I enter "New name" into input named "contact-name-input"
  And I click on "#contact-name [type='submit']"
  And I click on "#contact-telephone-number .fa-edit"
  And I enter "00000000" into input named "contact-telephone-number-input"
  And I click on "#contact-telephone-number [type='submit']"
  And I click on "#contact-email .fa-edit"
  And I enter "new@example.com" into input named "contact-email-input"
  And I click on "#contact-email [type='submit']"
  And I reload the page
  Then the element "#contact-name" contain the text "New name"
  And the element "#contact-telephone-number" contain the text "00000000"
  And the element "#contact-email" contain the text "new@example.com"

@javascript
Scenario: Change main responsable
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Projects"
  And I click on link "Test project"
  And I click on "#main-responsable .text"
  Then the element "#main-responsable .text" does not contain the text "user2"
  And I click on "#main-responsable input"
  And I click on "#main-responsable .item:nth-child(2)"
  Then the element "#main-responsable .text" contain the text "user2"
  And I reload the page
  Then the element "#main-responsable .text" contain the text "user2"

@javascript
Scenario: Change main responsable
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Projects"
  And I click on link "Test project"
  And I click on ".reminder-list .fa-plus"
  And I enter "New reminder" into input named "Title"
  And I click on "#input-group-due-at"
  And I click on "tr:last-of-type > [data-day]:last-of-type"
  And I click on ".modal-content"
  And I click on submit
  Then the page contain the text "New reminder"
  When I reload the page
  Then the page contain the text "New reminder"

@javascript
Scenario: Change project status
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Projects"
  And I click on link "Test project"
  And I click on "#project-status-select .text"
  Then the element "#project-status-select .text" does not contain the text "Active"
  And I click on "#project-status-select input"
  And I click on "#project-status-select .item:nth-child(3)"
  Then the element "#project-status-select .text" contain the text "Active"
  And I reload the page
  Then the element "#project-status-select .text" contain the text "Active"

@javascript
Scenario: Paggination
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Projects"
  And I click on "[aria-label='Go to page 2']"
  Then the page contain the text "Test project 11"
