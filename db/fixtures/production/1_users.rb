# frozen_string_literal: true

if User.none?
  Admin.seed do |s|
    s.id        = 1
    s.email     = "admin@lvh.me"
    s.firstname = "Test"
    s.lastname  = "Test"
    s.password  = "testtest"
    s.invitation_accepted_at = Time.zone.now
  end
end
