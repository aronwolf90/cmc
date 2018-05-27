Feature: WikiContent

@javascript
Scenario: show wikis content
  Given I am signed in
  And a wiki category exists
  And I click on link "Wiki"
  Then the page contain the text "wiki category title" 
