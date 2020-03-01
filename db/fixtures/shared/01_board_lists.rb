# frozen_string_literal: true

BoardList.seed do |s|
  s.id         = 1
  s.name       = "Open"
  s.kind       = "open"
end

BoardList.seed do |s|
  s.id         = 2
  s.name       = "In progress"
  s.kind       = "other"
end

BoardList.seed do |s|
  s.id         = 3
  s.name       = "Closed"
  s.kind       = "closed"
end
