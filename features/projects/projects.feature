Feature: Projects

@javascript
Scenario: Manage project
  Given a test-organization exists
  And I am signed in (multitenant)
  # Create
  When I click on link "Projects"
  And I click on link "New project"
  And I enter "project title" into input named "Name"
  And I click on submit
  Then the element "#side-body" contain the text "Test project 2"
  When I click on "[aria-label='Go to last page']"
  Then the element "#side-body" contain the text "project title"
  # Update
  When I reload the page
  And I click on navbar link "Projects"
  And I click on "[aria-label='Go to last page']"
  And I click on link "project title"
  And I click on ".fa-edit"
  And I enter "project title new" into input named "name-input"
  And I click on submit
  Then the element "#side-body" contain the text "project title new"
  # Comment
  When I replace the text "test comment" from the markdown editor ".comments .markdown-editor"
  And I click on ".comments .btn"
  Then the element ".comment" contain the text "test comment"
  When I reload the page
  Then the element ".comment" contain the text "test comment"
  # Edit contact inputs
  When I click on "#contact-name .fa-edit"
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
  When I click on "#main-responsable .text"
  And I click on "#main-responsable input"
  And I click on "#main-responsable .item:nth-child(2)"
  Then the element "#main-responsable .text" contain the text "user2"
  When I reload the page
  Then the element "#main-responsable .text" contain the text "user2"
  # Create new reminder
  And I click on ".reminder-list .fa-plus"
  And I enter "New reminder" into input named "Title"
  And I click on "#input-group-due-at"
  And I click on "tr:last-of-type > [data-day]:last-of-type"
  And I click on ".modal-content"
  And I click on submit
  Then the page contain the text "New reminder"
  When I reload the page
  Then the page contain the text "New reminder"
  # Change project status
  And I click on "#project-status-select .text"
  Then the element "#project-status-select .text" does not contain the text "Active"
  And I click on "#project-status-select input"
  And I click on "#project-status-select .item:nth-child(3)"
  Then the element "#project-status-select .text" contain the text "Active"
  And I reload the page
  Then the element "#project-status-select .text" contain the text "Active"
  # Create project with project status
  When I click on link "Projects"
  And I click on link "New project"
  And I enter "New project with status" into input named "Name"
  And select "New" from select box "Project status"
  And I click on submit
  Then the element "#side-body" contain the text "New project with status"

@javascript
Scenario: Paggination
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on navbar link "Projects"
  And I click on "[aria-label='Go to page 2']"
  Then the page contain the text "Test project 11"
