# frozen_string_literal: true

Record.seed do |s|
  s.id          = 1
  s.user_id     = 1
  s.issue_id    = 5
  s.start_time  = 1.week.ago - 1.hour
  s.end_time    = 1.week.ago
end

Record.seed do |s|
  s.id          = 2
  s.user_id     = 1
  s.issue_id    = 7
  s.start_time  = 3.weeks.ago - 2.hours
  s.end_time    = 3.weeks.ago
end

Record.seed do |s|
  s.id          = 3
  s.user_id     = 1
  s.issue_id    = 7
  s.start_time  = 6.weeks.ago - 1.5.hours
  s.end_time    = 6.weeks.ago
end

Record.seed do |s|
  s.id          = 4
  s.user_id     = 1
  s.issue_id    = 8
  s.start_time  = 12.weeks.ago - 20.hours
  s.end_time    = 12.weeks.ago
end

Record.seed do |s|
  s.id          = 5
  s.user_id     = 2
  s.issue_id    = 6
  s.start_time  = 16.weeks.ago - 7.hours
  s.end_time    = 16.weeks.ago
end

Record.seed do |s|
  s.id          = 6
  s.user_id     = 2
  s.issue_id    = 8
  s.start_time  = 18.weeks.ago - 9.hours
  s.end_time    = 18.weeks.ago
end
