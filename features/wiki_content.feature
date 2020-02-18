Feature: WikiContent

@javascript
Scenario: show wikis content
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Wiki"
  Then the page contain the text "category 1" 
