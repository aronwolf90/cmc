# frozen_string_literal: true

Label.seed do |s|
  s.id    = 1
  s.name  = "Bug"
  s.color = "#ff0000"
end

Label.seed do |s|
  s.id    = 2
  s.name  = "Important"
  s.color = "#ff0000"
end

IssueLabel.seed do |s|
  s.label_id = 1
  s.issue_id = 1
end
