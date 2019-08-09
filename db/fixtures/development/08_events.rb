# frozen_string_literal: true

Event.seed do |s|
  s.id         = 1
  s.title      = "Test event"
  s.start_time = Date.today
  s.all_day    = true
end
