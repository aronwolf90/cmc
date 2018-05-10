# frozen_string_literal: true

Given /^an user exists with an id of 1$/ do
  User.create!(id: 1, email: "test@localhost.de", password: "testtest", password_confirmation: "testtest")
end

Given /^an project with an id of 1 exists$/ do
  Project.create!(id: 1, name: "project name")
end

Given /^I am an user with an id of 1$/ do
  User.create!(id: 1, email: "test@localhost.de", password: "testtest", password_confirmation: "testtest")
end

Given /^I am an user with an email "test@localhost.de" and a password "testtest" and and id of "1"$/ do
  User.create!(id: 1, email: "test@localhost.de", password: "testtest", password_confirmation: "testtest")
end

Given /^an issue exists with an id of 1$/ do
  Issue.create!(id: 1, title: "title")
end

Given /^an issue exists with an id of 2$/ do
  Issue.create!(id: 2, title: "title")
end

Given /^an record exists with an id of 1$/ do
  Record.create!(id: 1)
end

Given /^I with an id of 1 have an current record$/ do
  Record.create!(id: 1, user_id: 1, start_time: "2018-02-04T12:00:00.000Z")
end

Given /^a board list exists with an id of 1$/ do
  BoardList.create!(id: 1, name: "name")
end

Given /^a board list exists with an id of 2$/ do
  BoardList.create!(id: 2, name: "name")
end
