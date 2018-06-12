# frozen_string_literal: true

def find_or_create_current_user
  User.create_with(
    password: "testtest",
    password_confirmation: "testtest",
    firstname: "aron",
    lastname: "wolf"
  ).find_or_create_by!(email: "aronwolf90@gmail.com")
end

Given(/^I am registered$/) do
  User.create!(email: "aronwolf90@gmail.com", password: "testtest", password_confirmation: "testtest")
end

Given(/^I am not registered$/) do; end

Given(/^I am signed in$/) do
  find_or_create_current_user
  visit "/users/sign_in"
  fill_in "user_email", with: "aronwolf90@gmail.com"
  fill_in "user_password", with: "testtest"
  find('input[name="commit"]').click
end

Given(/I have an old record/) do
  board_list = BoardList.create!(name: "Backlog")

  issue = Issue.create!(
    title: "issues title",
    description: "issues content",
    board_list: board_list
  )

  Record.create(
    start_time: 2.hour.ago,
    end_time: 1.hour.ago,
    issue: issue,
    user: find_or_create_current_user
  )
end

Given(/^an issue exists$/) do
  board_list = BoardList.create!(name: "Backlog")
  Issue.create!(title: "issues title", description: "issues content", board_list: board_list)
end

Given(/^I have spent time one a project$/) do
  project = Project.create!(name: "project")
  board_list = BoardList.create!(name: "Backlog", project: project)
  issue = Issue.create!(title: "issues title", description: "issues content", board_list: board_list)
  Record.create(
    start_time: 2.hour.ago,
    end_time: 1.hour.ago,
    issue: issue,
    user: find_or_create_current_user
  )
end

Given(/^an issue with title "([^\"]*)" exists$/) do |title|
  board_list = BoardList.create!(name: "Backlog")
  Issue.create!(title: title, description: "issues content", board_list: board_list)
end

Given(/^an issue with title "([^\"]*)" and content "([^\"]*)" exists$/) do |title, content|
  board_list = BoardList.create!(name: "Backlog")
  Issue.create!(title: title, description: content, board_list: board_list)
end

Given(/^an acive issue exists$/) do
  board_list = BoardList.create!(name: "Backlog")
  issue = Issue.create!(
    title: "issues title", description: "issues content",
    board_list: board_list
  )
  issue.create_record(start_time: Time.zone.now, user: find_or_create_current_user)
end

Given(/^a board list named "([^\"]*)"$/) do |name|
  BoardList.create!(name: name)
end

Given(/^a document exists with name "([^\"]*)" exists$/) do |name|
  Document.create(
    name: name,
    folder: Folder.create!(name: "fodler"),
    file: File.open("/etc/hostname")
  )
end

Given(/^a project exists$/) do
  Project.create!(name: "project name")
end

Given(/^a wiki category exists$/) do
  WikiCategory.create!(title: "wiki category title")
end

Given(/^an wiki page with title "([^\"]*)" and content "([^\"]*)" exists/) do |title, content|
  wiki_category = WikiCategory.create!(title: "wiki category title")
  WikiPage.create!(
    title: title,
    content: content,
    wiki_category: wiki_category
  )
end

Given(/^an wiki page with title "([^\"]*)" exists$/) do |title|
  WikiCategory.create!(title: title)
end

Given(/^a folder exists with name "([^\"]*)"$/) do |name|
  Folder.create!(name: name)
end

When(/^I navigate to "([^\"]*)"$/) do |link|
  visit link
end

When(/^I enter "([^\"]*)" into input named "([^\"]*)"$/) do |text, name|
  fill_in name, with: text
end

When(/^I replace the text "([^\"]*)" from the markdown editor "([^\"]*)"$/) do |text, element|
  js_comand = "$('#{element}')[0].editor.setValue('#{text}')"
  page.driver.browser.execute_script(js_comand)
end

When(/^I enter "([^\"]*)" into "([^\"]*)"$/) do |text, element|
  find(element).set(text)
end

When(/^I click on submit$/) do
  find('input[name="commit"], button[type="submit"]').click
end

When(/^I click on "([^\"]*)"$/) do |element|
  sleep 0.1
  find(element).click
end

When(/^I click on link "([^\"]*)"$/) do |text|
  sleep 0.1
  find("a", text: text).click
end

When(/^select "([^\"]*)" from select box "([^\"]*)"$/) do |text, name|
  select text, from: name
end

When(/^I reload the page$/) do
  sleep 0.1 # wait for for unfinished requests
  page.driver.browser.navigate.refresh
end

Then(/^the page contain the text "([^\"]*)"$/) do |text|
  expect(page).to have_content text
end

Then (/^I enter enter a file into input named "([^\"]*)"$/) do |element|
  page.attach_file(element, "/etc/hostname")
end

Then(/^the page does not contain the text "([^\"]*)"$/) do |text|
  sleep(0.1)
  expect(page).not_to have_content text
end

Then(/^the element "([^\"]*)" contain the text "([^\"]*)"$/) do |element, text|
  within element do
    expect(page).to have_content text
  end
end

Then(/^the element "([^\"]*)" does not contain the text "([^\"]*)"$/) do |element, text|
  within element do
    expect(page).not_to have_content text
  end
end

Then(/^the page contain the element "([^\"]*)"$/) do |text|
  sleep(0.1)
  expect(page).to have_css text
end

Then(/^I am on page "([^\"]*)"$/) do |link|
  sleep(0.1)
  expect(page).to have_current_path(link)
end

Then(/^the input "([^\"]*)" has the value "([^\"]*)"$/) do |input_name, value|
  sleep(0.1)
  expect(find_field(input_name).value).to eq value
end
