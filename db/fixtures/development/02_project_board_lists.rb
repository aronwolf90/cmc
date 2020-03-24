# frozen_string_literal: true

ProjectBoardList.seed do |s|
  s.id                = 1
  s.name              = "New"
  s.project_status_id = 1
end

ProjectBoardList.seed do |s|
  s.id                = 2
  s.name              = "In contact"
  s.project_status_id = 1
end

ProjectBoardList.seed do |s|
  s.id                = 3
  s.name              = "In revision"
  s.project_status_id = 1
end

ProjectBoardList.seed do |s|
  s.id                = 4
  s.name              = "Default"
  s.project_status_id = 2
end

ProjectBoardList.seed do |s|
  s.id                = 5
  s.name              = "Default"
  s.project_status_id = 3
end
