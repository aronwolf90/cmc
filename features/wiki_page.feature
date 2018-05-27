Feature: Wiki page

@javascript
Scenario: Create wiki page
  Given an wiki page with title "category" exists
  And I am signed in
  When I click on link "Wiki"
  And I click on link "add page"
  And I enter "page title" into input named "data[title]"
  And select "category" from select box "data[wiki_category_id]"
  And I click on submit
  Then the element "#side-body" contain the text "page title"

@javascript
Scenario: Show wiki page
  Given an wiki page with title "title" and content "content" exists
  And I am signed in
  When I click on link "Wiki"
  And I click on link "title"
  Then the element "#side-body" contain the text "title"
  And the element "#side-body" contain the text "content"

@javascript
Scenario: Edit wiki page
  Given an wiki page with title "title" and content "content" exists
  And I am signed in
  When I click on link "Wiki"
  And I click on link "title"
  And I click on ".fa-edit"
  And I replace the text "test" from the markdown editor "form .markdown-editor"
  And I click on submit
  Then the element "#side-body" contain the text "test"
  When I reload the page
  Then the element "#side-body" contain the text "test"
