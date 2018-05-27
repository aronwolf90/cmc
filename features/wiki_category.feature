Feature: Wiki page

@javascript
Scenario: Create wiki page
  Given I am signed in
  When I click on link "Wiki"
  And I click on link "add category"
  And I enter "category title" into input named "data[title]"
  And I click on submit
  Then the element "#side-body" contain the text "category title"
