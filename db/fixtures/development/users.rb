User.seed do |s|
  s.id        = 1
  s.email     = 'aronwolf90@gmail.com'
  s.firstname = 'Aron'
  s.lastname  = 'Wolf'
  s.password  = 'testtest'
  s.invitation_accepted_at = Time.zone.now
end
