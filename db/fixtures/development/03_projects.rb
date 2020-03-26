# frozen_string_literal: true

Project.seed do |s|
  s.id                    = 1
  s.name                  = "Test project"
  s.description           = "Test description"
  s.project_board_list_id = 1
end

Project.seed do |s|
  s.id                    = 2
  s.name                  = "Test project 2"
  s.description           = "Test description"
  s.project_board_list_id = 2
end
