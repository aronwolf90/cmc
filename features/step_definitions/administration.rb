# frozen_string_literal: true

Given(/^The app contain seed data$/) do
  suppress_output do
    load Rails.root.join("db", "seeds.rb")
  end
end

Given(/^Multi tenant is enabled$/) do
  allow(Settings).to receive(:multi_tenant).and_return(true)
end

Given(/^a test-organization exists$/) do
  allow(Settings).to receive(:multi_tenant).and_return(true)
  RestClient.post(
    "#{Capybara.app_host}/api/v1/test_organizations",
    { data: { attributes: {} } }.to_json, content_type: :json, accept: :json
  )
end

Given(/^a test-organization exists with global board lists$/) do
  visit("/")
  RestClient.post(
    "#{Capybara.app_host}/api/v1/test_organizations",
    { data: { attributes: { "global-board": true } } }.to_json,
    content_type: :json, accept: :json
  )
end

Given(/^no "test-organization" exists$/) do
  RestClient.delete("#{Capybara.app_host}/api/v1/test_organizations")
end

Given(/^a premium test-organization exists$/) do
  visit("/")
  allow(Settings).to receive(:multi_tenant).and_return(true)
  RestClient.post(
    "#{Capybara.app_host}/api/v1/test_organizations",
    { data: { attributes: { premium: 1 } } }.to_json, content_type: :json, accept: :json
  )
end

Given(/^I am registered$/) do
  Admin.create!(email: "admin@lvh.me", password: "testtest", password_confirmation: "testtest")
end

Given(/^I am not registered$/) { ; }

Given(/^I am signed in$/) do
  find_or_create_current_user
  visit "/users/sign_in"
  fill_in "user_email", with: "admin@lvh.me"
  fill_in "user_password", with: "testtest"
  find('input[name="commit"]').click
end

Given(/^Organization is not premium$/) do
  Organization.first.update!(subscription_id: nil, id: 2)
end

Given(/^I am signed in \(multitenant\)$/) do
  visit "http://test-organization.lvh.me:3000/users/sign_in"
  expect(page).to have_css "[name='user_email'], #user_email"
  fill_in "user_email", with: "admin@lvh.me"
  fill_in "user_password", with: "testtest"
  find('input[name="commit"]').click
end

Given(/^set "([^\"]*)" as current organization$/) do |tenant|
  Apartment::Tenant.switch!(tenant)
end

Given(/^5 additional users exist$/) do
  FactoryBot.create_list(:admin, 5)
end

When(/^I navigate to "([^\"]*)"$/) do |link|
  visit link
end

When(/^I enter "([^\"]*)" into input named "([^\"]*)"$/) do |text, name|
  fill_in name, with: text
  find("body").click
end

When(/^I enter "([^\"]*)" into input "([^\"]*)"$/) do |text, element|
  find(element).set text
end

When(/^I check the input named "([^\"]*)"$/) do |name|
  check name, allow_label_click: true
end

When(/^an acive issue exists$/) do
  expect(page).to have_css ".fa-play"
  find(".fa-play", match: :prefer_exact).click
end

When(/^I replace the text "([^\"]*)" from the markdown editor "([^\"]*)"$/) do |text, element|
  expect(page).to have_css element
  js_comand = "$('#{element}')[0].editor.setValue('#{text}')"
  page.driver.browser.execute_script(js_comand)
end

When(/^I enter "([^\"]*)" into "([^\"]*)"$/) do |text, element|
  expect(page).to have_css element
  find(element).set(text)
end

When(/^I click on submit$/) do
  expect(page).to have_css 'input[name="commit"], button[type="submit"]'
  find('input[name="commit"], button[type="submit"]').click
end

When(/^I click on "([^\"]*)"$/) do |element|
  expect(page).to have_css element
  find(element, match: :prefer_exact).click
end

When(/^I click on "([^\"]*)" with "([^\"]*)"$/) do |element, text|
  expect(page).to have_css element
  find(element, text: text, match: :prefer_exact).click
end

When(/^I click on link "([^\"]*)"$/) do |text|
  expect(page).to have_text text
  find("a", text: text, match: :prefer_exact).click
end

When(/^I click on body link "([^\"]*)"$/) do |text|
  expect(page).to have_text text
  find(".body-content a", text: text, match: :prefer_exact).click
end

When(/^I click on aside link "([^\"]*)"$/) do |text|
  expect(page).to have_text text
  find(".nav a", text: text, match: :prefer_exact).click
end

When(/^I click on navbar link "([^\"]*)"$/) do |text|
  expect(page).to have_text text
  find("nav.fixed-top a", text: text, match: :prefer_exact).click
  expect(page).to have_css("nav.fixed-top a.active", text: text)
end

When(/^I click on button "([^\"]*)"$/) do |text|
  expect(page).to have_text text
  find("button", text: text, match: :prefer_exact).click
end

When(/^select "([^\"]*)" from select box "([^\"]*)"$/) do |text, name|
  select text, from: name
end

When(/^I reload the page$/) do
  sleep 0.2 # wait for for unfinished requests
  page.driver.browser.navigate.refresh
end

When(/^Travel to 11.06.2018 17:00:00$/) do
  Timecop.travel("11.06.2018 17:00:00")
end

When(/^I drag "([^\"]*)" to "([^\"]*)"$/) do |from, to|
  source_node = page.find(from)
  target_node = page.find(to)
  source_node.drag_to(target_node, delay: 2)
end

When(/^I set due at to one hour from now$/) do
  fill_in(
    "due-at",
    with: 1.hour.from_now.strftime("%d-%m-%Y %H:%M"),
    match: :prefer_exact
  )
end

When(/^I sleep "([^\"]*)" seconds/) do |seconds|
  sleep seconds.to_i.seconds
end

When(/^I reload until "([^\"]*)" with text "([^\"]*)"$/) do |element, text|
  20.times do
    page.driver.browser.navigate.refresh
    break if page.has_css?(element, wait: 1.second, text: text)
  end
end

Then(/^the page contain the text "([^\"]*)"$/) do |text|
  expect(page).to have_content text
end

Then (/^I enter enter a file into input named "([^\"]*)"$/) do |element|
  input = find(:xpath, "//label[contains(text(), '#{element}')]")[:for]
  page.attach_file(input, "/etc/hostname", visible: false)
end

Then(/^the page does not contain the text "([^\"]*)"$/) do |text|
  expect(page).not_to have_content text
end

Then(/^the element "([^\"]*)" contain the text "([^\"]*)"$/) do |element, text|
  expect(page).to have_css element
  within element do
    expect(page).to have_content text
  end
end

Then(/^the element "([^\"]*)" does not contain the text "([^\"]*)"$/) do |element, text|
  expect(page).to have_css element
  within element do
    expect(page).not_to have_content text
  end
end

Then(/^the page contain the element "([^\"]*)"$/) do |text|
  expect(page).to have_css text
end

Then(/^the page does not contain the element "([^\"]*)"$/) do |text|
  expect(page).not_to have_css text
end

Then(/^I am on page "([^\"]*)"$/) do |link|
  expect(page).to have_current_path(link)
end

Then(/^the input "([^\"]*)" has the value "([^\"]*)"$/) do |input_name, value|
  expect(find_field(input_name).value).to eq value
end

Then(/the page contain the current year/) do
  expect(page).to have_content Date.current.year
end

Then(/the page contain the year of one week ago/) do
  expect(page).to have_content 2.week.ago.year
end

Then(/the input "([^\"]*)" is checked/) do |input|
  expect(page).to have_checked_field(input, visible: false)
end
