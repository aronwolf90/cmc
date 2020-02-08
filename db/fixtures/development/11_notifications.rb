# frozen_string_literal: true

17.times do |n|
  Notification.seed do |s|
    s.id      = n + 1
    s.subject = "Nofification #{n+1}"
    s.body    = "body #{n+1}"
  end
end
