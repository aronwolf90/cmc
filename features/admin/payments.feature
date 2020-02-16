Feature: Payment page

@javascript
Scenario: Visit payment page when a subscription exist
  Given a test-organization exists
  And I am signed in (multitenant)
  When I click on link "Admin"
  And I click on link "Payment"
  Then the page contain the text "Add payment informations"

  #@javascript
  #Scenario: Call payment callback from stripe
  #  Given a test-organization exists
  #  And I am signed in (multitenant)
  #  When I navigate to "/administration/admin/payments?stripe_session_id=cs_test_8fh4AlX39Ncd3y8Rz2ysYSFOhPm8a4xkP4F2TnVOGnAMb61zyuCxXr50"
  #  Then the page contain the text "You have successfully added you payment information"
