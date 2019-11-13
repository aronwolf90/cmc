Feature: Payment page

@javascript
Scenario: Call payment callback from stripe
  Given The app contain seed data
  Given I am signed in
  When I click on link "Admin"
  When I click on link "Payment"
  Then the page contain the text "Add payment informations"

@javascript
Scenario: Call payment callback from stripe
  Given The app contain seed data
  Given I am signed in
  When I navigate to "/administration/admin/payments?stripe_session_id=cs_test_8fh4AlX39Ncd3y8Rz2ysYSFOhPm8a4xkP4F2TnVOGnAMb61zyuCxXr50"
  Then the page contain the text "You have successfully added you payment information"
