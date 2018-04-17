Feature: schared issue section

@javascript
Scenario: Start record time
  Given an issue exists
  And I am signed in
  When I navigate to "/administration/board"
  And I click on "#shared-issue-section .fa-play"
  Then the page contain the element "#shared-issue-section .fa-stop"

@javascript
Scenario: Stop record time
  Given an acive issue exists
  And I am signed in
  When I click on "#shared-issue-section .fa-stop"
  Then the page contain the element "#shared-issue-section .fa-play"

@javascript
Scenario: Filter issues
  Given an issue with title "issue title 1" exists
  And an issue with title "issue title 2" exists
  And I am signed in
  When I navigate to "/administration/board"
  Then the element "#shared-issue-section" contain the text "issue title 1"
  And the element "#shared-issue-section" contain the text "issue title 1"
  When I enter "issue title 2" into "#shared-issue-section input"
  Then the element "#shared-issue-section" does not contain the text "issue title 1"
  And the element "#shared-issue-section" contain the text "issue title 2"

# regresion test
@javascript
Scenario: Navigate from th current issue to his show view
  Given an acive issue exists
  And I am signed in
  When I click on link "issues title"
  Then the element "#side-body" contain the text "issues title"
