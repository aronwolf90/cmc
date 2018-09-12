Feature: Wiki page

@javascript
Scenario: Create wiki page
  Given The app contain seed data
  And I am signed in
  When I click on link "Wiki"
  And I click on link "add page"
  And I enter "page title" into input named "data[title]"
  And select "category 1" from select box "data[wiki_category_id]"
  And I click on submit
  Then the element "#side-body" contain the text "page title"

@javascript
Scenario: Show wiki page
  Given The app contain seed data
  And I am signed in
  When I click on link "Wiki"
  And I click on link "wiki page title"
  Then the element "#side-body" contain the text "wiki page title"
  And the element "#side-body" contain the text "test content"

@javascript
Scenario: Edit wiki page
  Given The app contain seed data
  And I am signed in
  When I click on link "Wiki"
  And I click on link "wiki page title"
  And I click on ".fa-edit"
  And I replace the text "wiki page test new" from the markdown editor "form .markdown-editor"
  And I click on submit
  Then the element "#side-body" contain the text "wiki page test new"
  When I reload the page
  Then the element "#side-body" contain the text "wiki page test new"
