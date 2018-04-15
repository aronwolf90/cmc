# frozen_string_literal: true

Given /^I am registered$/ do
  User.create!(email: "aronwolf90@gmail.com", password: "testtest", password_confirmation: "testtest")
end

Given /^I am not registered$/ do; end

Given /^I am signed in$/ do
  User.create!(email: "aronwolf90@gmail.com", password: "testtest", password_confirmation: "testtest")
  visit "/users/sign_in"
  fill_in "user_email", with: "aronwolf90@gmail.com"
  fill_in "user_password", with: "testtest"
  find('input[name="commit"]').click
end

Given /^an issue exists$/ do
  board_list = BoardList.create!(name: "Backlog")
  Issue.create!(title: "issues title", description: "issues content", board_list: board_list)
end

When(/^I navigate to "([^\"]*)"$/) do |link|
  visit link
end

When(/^I enter "([^\"]*)" into input named "([^\"]*)"$/) do |text, name|
  fill_in name, with: text
end

When(/^I click on submit$/) do
  find('input[name="commit"]').click
end

When(/^I click on "([^\"]*)"$/) do |element|
  find(element).click
end

Then(/^the page contain the text "([^\"]*)"$/) do |text|
  expect(page).to have_content text
end

Then(/^the page contain the element "([^\"]*)"$/) do |text|
  expect(page).to have_css text
end

Then(/^I am on page "([^\"]*)"$/) do |link|
  expect(page).to have_current_path(link)
end
