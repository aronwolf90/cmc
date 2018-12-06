# frozen_string_literal: true

BoardList.seed do |s|
  s.id         = 1
  s.name       = "Open"
  s.project_id = 1
end

BoardList.seed do |s|
  s.id         = 2
  s.name       = "Doing"
  s.project_id = 1
end

BoardList.seed do |s|
  s.id         = 3
  s.name       = "Closed"
  s.project_id = 1
end
