Feature: Jobs -> create notifications

@javascript
Scenario: create notifications
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on ".notification-bell"
  And I click on link "Issues"
  And I click on link "Test issue 1"
  And I set due at to one hour from now
  And I click on ".due-at button"
  And I navigate to "http://admin:testtest@lvh.me:3000/sidekiq/cron"
  And I click on "[action='/sidekiq/cron/create_notifications/enque'] [type='submit']"
  And I sleep "2" seconds
  And I navigate to "http://test-organization.lvh.me:3000/administration"
  Then the element ".badge-pill" contain the text "1"
