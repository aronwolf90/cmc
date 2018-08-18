# frozen_string_literal: true

Admin.seed do |s|
  s.id        = 1
  s.email     = "admin@lvh.me"
  s.firstname = "Aron"
  s.lastname  = "Wolf"
  s.password  = "testtest"
  s.invitation_accepted_at = Time.zone.now
end

Employee.seed do |s|
  s.id        = 2
  s.email     = "employee@lvh.me"
  s.firstname = "user2"
  s.lastname  = "simson"
  s.password  = "testtest"
  s.invitation_accepted_at = Time.zone.now
end


Customer.seed do |s|
  s.id        = 3
  s.email     = "customer@lvh.me"
  s.firstname = "user3"
  s.lastname  = "Herrera"
  s.password  = "testtest"
  s.invitation_accepted_at = Time.zone.now
end
