Feature: Payment page

@javascript
Scenario: Create/Update subscription
  Given a test-organization exists
  And I am signed in (multitenant)
  And no payment data is present
  When I click on link "Admin"
  And I click on link "Payment"
  And the page contain the text "Add payment informations"
  And I click on button "Add payment informations"
  And I enter "test@example.com" into input named "email"
  And I click on "[name='cardNumber']"
  And I sleep "1" seconds
  And I enter "4242424242424242" into input named "cardNumber"
  And I enter "12/40" into input named "cardExpiry"
  And I enter "1234" into input named "cardCvc"
  And I enter "Lara Croft" into input named "billingName"
  And I select the value "DE" from select box "billingCountry"
  And I click on ".SubmitButton-IconContainer"
  Then the page contain the text "Add payment informations"
  And the page contain the text "4242"
  When the page contain the text "Add payment informations"
  And I click on button "Add payment informations"
  And I enter "test@example.com" into input named "email"
  And I click on "[name='cardNumber']"
  And I sleep "1" seconds
  And I enter "5555555555554444" into input named "cardNumber"
  And I enter "12/40" into input named "cardExpiry"
  And I enter "1234" into input named "cardCvc"
  And I enter "Lara Croft" into input named "billingName"
  And I select the value "DE" from select box "billingCountry"
  And I click on ".SubmitButton-IconContainer"
  Then the page contain the text "Add payment informations"
  And the page contain the text "4444"
