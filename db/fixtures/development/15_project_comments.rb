# frozen_string_literal: true

ProjectComment.seed do |s|
  s.id          = 1
  s.content     = "Test content"
  s.user_id     = 1
  s.project_id  = 1
end
