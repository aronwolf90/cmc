Feature: WikiContent

@javascript
Scenario: show wikis content
  Given The app contain seed data
  And I am signed in
  When I click on link "Wiki"
  Then the page contain the text "category 1" 
