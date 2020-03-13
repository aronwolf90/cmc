# frozen_string_literal: true

ProjectStatus.seed do |s|
  s.id      = 1
  s.name    = "New"
  s.initial = true
end

ProjectStatus.seed do |s|
  s.id      = 2
  s.name    = "Active"
  s.initial = false
end

ProjectStatus.seed do |s|
  s.id      = 3
  s.name    = "Archived"
  s.initial = false
end
