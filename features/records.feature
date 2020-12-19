Feature: Records

@javascript
Scenario: Manage Records
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Records"
  Then the element "#side-body" contain the text "Test issue 7"
  # Record new
  And I click on link "New record"
  And I click on "#issue-input" 
  And I click on "[role='option']" with "Test issue 1"
  And I click on "label" with "Start time"
  And I click on "tr:last-of-type > [data-day]:nth-last-of-type(2)"
  And I click on ".search-section" 
  And I click on "label" with "End time"
  And I click on "tr:last-of-type > [data-day]:last-of-type"
  And I click on ".search-section"
  And I click on submit
  Then the element "#side-body" contain the text "Test issue 1"
  # Record edit
  And I click on ".fa-edit"
  And I click on "#data_end_time"
  And I click on "tr:last-of-type > [data-day]:last-of-type"
  And I click on "label"
  And I click on submit
  Then the page contain the year of one week ago
  # Downlad csv
  When I click on link "Records"
  And I click on ".fa-file-excel-o"
