# frozen_string_literal: true

BoardList.seed do |s|
  s.id         = 4
  s.name       = "Backlog"
  s.project_id = 1
  s.kind       = "open"
end

BoardList.seed do |s|
  s.id         = 5
  s.name       = "In development"
  s.project_id = 1
  s.kind       = "other"
end

BoardList.seed do |s|
  s.id         = 6
  s.name       = "Closed"
  s.project_id = 1
  s.kind       = "closed"
end

BoardList.seed do |s|
  s.id         = 7
  s.name       = "Test project 2 open"
  s.project_id = 2
  s.kind       = "open"
end

BoardList.seed do |s|
  s.id         = 8
  s.name       = "In development"
  s.project_id = 2
  s.kind       = "other"
end

BoardList.seed do |s|
  s.id         = 9
  s.name       = "Closed"
  s.project_id = 2
  s.kind       = "closed"
end
