# frozen_string_literal: true

Issue.seed do |s|
  s.id                    = 1
  s.board_list_id         = 4
  s.global_board_list_id  = 1
  s.complexity            = 2
  s.user_id               = 1
  s.title                 = "Test issue 1"
  s.description           = "description for the test issue"
  s.ordinal_number        = 3
  s.global_ordinal_number = 3
  s.due_at                = "10-10-2020 00:00"
  s.deadline_at           = "10-10-2020 00:00"
end

Issue.seed do |s|
  s.id                    = 2
  s.board_list_id         = 4
  s.global_board_list_id  = 1
  s.complexity            = 2
  s.user_id               = 1
  s.title                 = "Test issue 2"
  s.description           = "description for the test issue"
  s.ordinal_number        = 2
  s.global_ordinal_number = 2
end

Issue.seed do |s|
  s.id                    = 3
  s.board_list_id         = 4
  s.global_board_list_id  = 1
  s.complexity            = 3
  s.title                 = "Test issue 3"
  s.description           = "description for the test issue"
  s.ordinal_number        = 1
  s.global_ordinal_number = 1
end

Issue.seed do |s|        
  s.id                    = 4
  s.board_list_id         = 4
  s.global_board_list_id  = 1
  s.complexity            = 5
  s.title                 = "Test issue 4"
  s.description           = "description for the test issue"
  s.ordinal_number        = 0
  s.global_ordinal_number = 0
end

Issue.seed do |s|        
  s.id                    = 5
  s.board_list_id         = 5
  s.global_board_list_id  = 2
  s.complexity            = 8
  s.title                 = "Test issue 5"
  s.description           = "description for the test issue"
  s.ordinal_number        = 2
  s.global_ordinal_number = 2
end

Issue.seed do |s|        
  s.id                    = 6
  s.board_list_id         = 5
  s.global_board_list_id  = 2
  s.complexity            = 2
  s.title                 = "Test issue 6"
  s.description           = "description for the test issue"
  s.ordinal_number        = 1
  s.global_ordinal_number = 1
end

Issue.seed do |s|        
  s.id                    = 7
  s.board_list_id         = 5
  s.global_board_list_id  = 2
  s.complexity            = 8
  s.title                 = "Test issue 7"
  s.description           = "description for the test issue"
  s.ordinal_number        = 0
  s.global_ordinal_number = 0
end

Issue.seed do |s|        
  s.id                    = 8
  s.board_list_id         = 6
  s.global_board_list_id  = 3
  s.complexity            = 1
  s.title                 = "Test issue 8"
  s.description           = "description for the test issue"
  s.ordinal_number        = 3
  s.global_ordinal_number = 3
end

Issue.seed do |s|        
  s.id                    = 9
  s.board_list_id         = 6
  s.global_board_list_id  = 3
  s.complexity            = 8
  s.title                 = "Test issue 9"
  s.description           = "description for the test issue"
  s.ordinal_number        = 2
  s.global_ordinal_number = 2
end

Issue.seed do |s|        
  s.id                    = 10
  s.board_list_id         = 6
  s.global_board_list_id  = 3
  s.complexity            = 3
  s.title                 = "Test issue 10"
  s.description           = "description for the test issue"
  s.ordinal_number        = 1
  s.global_ordinal_number = 1
end

Issue.seed do |s|        
  s.id                    = 11
  s.board_list_id         = 6
  s.global_board_list_id  = 3
  s.complexity            = 5
  s.title                 = "Test issue 11"
  s.description           = "description for the test issue"
  s.ordinal_number        = 0
  s.global_ordinal_number = 0
end
