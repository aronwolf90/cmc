# frozen_string_literal: true

AttendanceEvent.seed do |s|
  s.id          = 1
  s.from_day    = "2019-01-15"
  s.to_day      = "2019-01-16"
  s.from_time   = "09:00"
  s.to_time     = "18:00"
  s.description = "Test description"
  s.user_id     = 1
end

AttendanceEvent.seed do |s|
  s.id          = 2
  s.from_day    = Date.today + 1.day
  s.to_day      = Date.today + 1.day
  s.from_time   = Time.zone.now + 1.day
  s.to_time     = Time.zone.now + 1.day + 10.seconds
  s.description = "Test description"
  s.user_id     = 1
end
