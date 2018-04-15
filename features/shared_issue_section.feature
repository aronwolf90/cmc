Feature: schared issue section

@javascript
Scenario: Start record time
  Given I am signed in
  And an issue exists
  When I navigate to "/administration/board"
  When I click on "#shared-issue-section .fa-play"
  Then the page contain the element "#shared-issue-section .fa-stop"
