Feature: Records

Scenario: Records index
  Given The app contain seed data
  And I am signed in
  When I click on link "Records"
  Then the element "#side-body" contain the text "Test issue 5"

Scenario: Record new
  Given The app contain seed data
  And I am signed in
  When I click on link "Records"
  And I click on link "add record"
  And select "Test issue 1" from select box "data[issue_id]"
  And I enter "12:00:00 01:01:2017" into input named "data[start_time]"
  And I enter "12:01:00 01:01:2017" into input named "data[end_time]"
  And I click on submit
  Then the element "#side-body" contain the text "Test issue 1"

@javascript
Scenario: Record edit
  Given The app contain seed data
  And I am signed in
  When I click on link "Records"
  And I click on ".fa-edit"
  And I enter "2020.01.01 01:41:43" into input named "data[end_time]"
  And I click on submit
  Then the page contain the text "2018"
