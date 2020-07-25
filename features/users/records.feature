Feature: Records

@javascript
Scenario: Records index
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Users"
  And I click on link "Aron Wolf"
  And I click on link "Records"
  Then the element "#side-body" contain the text "Test issue 7"


@javascript
Scenario: Downlad csv
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Users"
  And I click on link "Aron Wolf"
  And I click on link "Records"
  And I click on ".fa-file-excel-o"
