# frozen_string_literal: true

Given /^an user exists with an id of 1$/ do
  Admin.create!(id: 1, email: "test@localhost.de", password: "testtest", password_confirmation: "testtest")
end

Given /^an project with an id of 1 exists$/ do
  Project.create!(id: 1, name: "project name")
end

Given /^a folder with an id of 1 exists$/ do
  Folder.create!(id: 1, name: "folder name")
end

Given /^I am an user with an id of 1$/ do
  Admin.create!(id: 1, email: "test@localhost.de", password: "testtest", password_confirmation: "testtest")
end

Given /^I am an user with an email "test@localhost.de" and a password "testtest" and and id of "1"$/ do
  Admin.create!(id: 1, email: "test@localhost.de", password: "testtest", password_confirmation: "testtest")
end

Given /^an issue exists with an id of 1$/ do
  project = Project.create!(name: "Test project")
  board_list = BoardList.create!(name: "Test", id: 10, project_id: project.id)
  Issue.create!(id: 1, title: "title", board_list: board_list)
end

Given /^an issue exists with an id of 2$/ do
  project = Project.create!(name: "Test project")
  board_list = BoardList.create!(name: "Test", id: 11, project: project)
  Issue.create!(id: 2, title: "title", board_list: board_list)
end

Given /^a wiki category with an id of 1 exists$/ do
  WikiCategory.create!(id: 1, title: "wiki category title")
end

Given /^an record exists with an id of 1$/ do
  Record.create!(id: 1)
end

Given /^I with an id of 1 have an current record$/ do
  Record.create!(id: 1, user_id: 1, start_time: "2018-02-04T12:00:00.000Z")
end

Given /^a board list exists with an id of 1$/ do
  project = Project.create!(name: "Test project")
  BoardList.create!(id: 1, name: "name", project: project)
end

Given /^a board list exists with an id of 2$/ do
  project = Project.create!(name: "Test project")
  BoardList.create!(id: 2, name: "name", project: project)
end

Given /^a wiki page exists with an id of 1$/ do
  wiki_category = WikiCategory.create!(id: 1, title: "title")
  WikiPage.create!(
    id: 1, title: "wiki page title",
    wiki_category: wiki_category, content: "content"
  )
end

Given /^an event exists with an id of 1$/ do
  Event.create!(
    title: "Test",
    all_day: true
  )
end

Given(/An record for user "([^\"]*)" and issue "([^\"]*)"/) do |user_id, issue_id|
  Record.create!(
    user_id: user_id,
    issue_id: issue_id,
    start_time: DateTime.parse("2018-06-11T16:59:00.049+02:00") - 1.minute,
    end_time: DateTime.parse("2018-06-11T16:59:00.049+02:00")
  )
end
