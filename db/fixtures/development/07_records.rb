# frozen_string_literal: true

date = "Sun, 16 Feb 2020 22:40:55 CET +01:00".to_date

Record.seed do |s|
  s.id          = 1
  s.user_id     = 1
  s.issue_id    = 5
  s.start_time  = date - 1.week - 1.hour
  s.end_time    = date - 1.week
end

Record.seed do |s|
  s.id          = 2
  s.user_id     = 1
  s.issue_id    = 7
  s.start_time  = date - 3.weeks - 2.hours
  s.end_time    = date - 3.weeks
end

Record.seed do |s|
  s.id          = 3
  s.user_id     = 1
  s.issue_id    = 7
  s.start_time  = date - 6.weeks - 1.5.hours
  s.end_time    = date - 6.weeks
end

Record.seed do |s|
  s.id          = 4
  s.user_id     = 1
  s.issue_id    = 8
  s.start_time  = date - 12.weeks - 20.hours
  s.end_time    = date - 12.weeks
end

Record.seed do |s|
  s.id          = 5
  s.user_id     = 2
  s.issue_id    = 6
  s.start_time  = date - 16.weeks - 7.hours
  s.end_time    = date - 16.weeks
end

Record.seed do |s|
  s.id          = 6
  s.user_id     = 2
  s.issue_id    = 8
  s.start_time  = date - 18.weeks - 9.hours
  s.end_time    = date - 18.weeks
end
