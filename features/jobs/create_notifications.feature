Feature: Jobs -> create notifications

@javascript
Scenario: create notifications
  Given a test-organization exists
  And I am signed in (multitenant)
  Then the element ".badge-pill" contain the text "17"
  When I click on ".notification-bell"
  And I click on link "Issues"
  And I click on link "Test issue 1"
  Then the page contain the text "description for the test issue"
  When I set due at to one hour from now
  And I click on ".due-at button"
  And I navigate to "http://admin:testtest@lvh.me:3000/sidekiq/cron"
  And I click on "[action='/sidekiq/cron/create_notifications/enque'] [type='submit']"
  And I navigate to "http://test-organization.lvh.me:3000/administration"
  And I reload until ".badge-pill" with text "1" 
  Then the element ".badge-pill" contain the text "1"
