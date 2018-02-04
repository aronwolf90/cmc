Given /^an user exists with an id of 1$/ do
  User.create!(id: 1, email: "test@localhost.de", password: "testtest")
end

Given /^an issue exists with an id of 1$/ do
  Issue.create!(id: 1, title: 'title')
end
