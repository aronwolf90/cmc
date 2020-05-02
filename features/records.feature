Feature: Records

@javascript
Scenario: Records index
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Records"
  Then the element "#side-body" contain the text "Test issue 7"

@javascript
Scenario: Record new
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Records"
  And I click on link "New record"
  And select "Test issue 1" from select box "data[issue_id]"
  And I click on "#data_start_time"
  And I click on "tr:last-of-type > [data-day]:nth-last-of-type(2)"
  And I click on "label"
  And I click on "#data_end_time"
  And I click on "tr:last-of-type > [data-day]:last-of-type"
  And I click on "label"
  And I click on submit
  Then the element "#side-body" contain the text "Test issue 1"

@javascript
Scenario: Record edit
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Records"
  And I click on ".fa-edit"
  And I click on "#data_end_time"
  And I click on "tr:last-of-type > [data-day]:last-of-type"
  And I click on "label"
  And I click on submit
  Then the page contain the year of one week ago
