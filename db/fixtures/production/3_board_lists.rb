# frozen_string_literal: true

BoardList.seed do |s|
  s.id         = 4
  s.name       = "Open"
  s.project_id = 1
end

BoardList.seed do |s|
  s.id         = 5
  s.name       = "Doing"
  s.project_id = 1
end

BoardList.seed do |s|
  s.id         = 6
  s.name       = "Closed"
  s.project_id = 1
end
