Feature: schared issue section

@javascript
Scenario: Start record time
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Tickets"
  And I sleep "1" seconds
  And I click on "#shared-issue-section .fa-play"
  Then the page contain the element "#shared-issue-section .fa-stop"

@javascript
Scenario: Stop record time
  Given a test-organization exists
  And I am signed in (multitenant)
  And an acive issue exists
  When I click on "#shared-issue-section .fa-stop"
  Then the page contain the element "#shared-issue-section .fa-play"

@javascript
Scenario: Filter issues
  Given a test-organization exists
  And I am signed in (multitenant)
  Then the element "#shared-issue-section" contain the text "Test issue 1"
  Then the element "#shared-issue-section" contain the text "Test issue 2"
  When I enter "2" into "#shared-issue-section input"
  Then the element "#shared-issue-section" does not contain the text "Test issue 1"
  And the element "#shared-issue-section" contain the text "Test issue 2"

# regresion test
@javascript
Scenario: Navigate from th current issue to his show view
  Given a test-organization exists
  And I am signed in (multitenant)
  And an acive issue exists
  When I click on link "Test issue 1"
  Then the element "#side-body" contain the text "Test issue 1"
