Feature: Project board lists

@javascript
Scenario: Create project board list
  Given a test-organization exists
  And I am signed in (multitenant)
  # Create
  When I click on link "Projects"
  And I click on aside link "New"
  And I click on ".body-content .fa-plus"
  And I enter "Test project board list" into input named "Name"
  And I click on submit
  Then the element "#side-body" contain the text "Test project board list"
  # Update
  When I reload the page
  And I click on link "Projects"
  And I click on aside link "New"
  And I click on "#column-6 .card-header .fa-edit"
  And I enter "Changed" into input named "Name"
  And I click on submit
  Then the page contain the text "Changed"
  And the page does not contain the text "Test project board list"
  # Destroy
  When I reload the page
  And I click on link "Projects"
  And I click on aside link "New"
  And I click on "#column-6 .card-header .fa-edit"
  And I click on button "Destroy"
  Then the page does not contain the text "Changed"
  When I reload the page
  And I click on link "Projects"
  Then the page does not contain the text "Changed"
