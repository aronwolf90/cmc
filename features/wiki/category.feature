Feature: Wiki page

@javascript
Scenario: Create wiki page
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Wiki"
  And I click on link "New wikicategory"
  And I enter "category title" into input named "Title"
  And I click on submit
  Then the element "#side-body" contain the text "New wikicategory"
  Then the element "#side-body" contain the text "category title"
  # Edit wiki category
  When I click on ".fa-edit"
  And I enter "Edited wiki category" into input named "Title"
  And I click on submit
  Then the element "#side-body" contain the text "New wikicategory"
  Then the element "#side-body" contain the text "Edited wiki category"
