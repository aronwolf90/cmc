# frozen_string_literal: true

BoardList.seed do |s|
  s.id    = 1
  s.name  = "Backlog"
end

BoardList.seed do |s|
  s.id    = 2
  s.name  = "In development"
end

BoardList.seed do |s|
  s.id    = 3
  s.name  = "Closed"
end
