Feature: Records

Scenario: Records index
  Given I have an old record
  And I am signed in
  When I click on link "Records"
  Then the element "#side-body" contain the text "issues title"

Scenario: Record new
  Given an issue with title "issues title" exists
  Given I am signed in
  When I click on link "Records"
  And I click on link "New record"
  And select "issues title" from select box "data[issue_id]"
  And I enter "12:00:00 01:01:2017" into input named "data[start_time]"
  And I enter "12:01:00 01:01:2017" into input named "data[end_time]"
  And I click on submit
  Then the element "#side-body" contain the text "issues title"

@javascript
Scenario: Record edit
  Given I have an old record
  Given I am signed in
  When I click on link "Records"
  And I click on ".fa-edit"
  And I enter "2020.01.01 01:41:43" into input named "data[end_time]"
  And I click on submit
  Then the page contain the text "2018"
