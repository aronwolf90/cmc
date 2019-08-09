# frozen_string_literal: true

BoardList.seed do |s|
  s.id         = 1
  s.name       = "Backlog"
  s.project_id = 1
end

BoardList.seed do |s|
  s.id         = 2
  s.name       = "In development"
  s.project_id = 1
end

BoardList.seed do |s|
  s.id         = 3
  s.name       = "Closed"
  s.project_id = 1
end

BoardList.seed do |s|
  s.id         = 4
  s.name       = "Test project 2 open"
  s.project_id = 2
end
