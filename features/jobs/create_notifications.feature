Feature: Jobs -> create notifications

@javascript
Scenario: create notifications
  Given a test-organization exists
  And I navigate to "http://admin:testtest@lvh.me:3000/sidekiq/cron"
  And I click on "[action='/sidekiq/cron/create_notifications/enque'] [type='submit']"
