# frozen_string_literal: true

Contact.seed do |s|
  s.id              = 1
  s.name            = "Clara"
  s.email           = "clara@test.example"
  s.description     = "Test description"
  s.telephone       = "01707986607"
  s.mobile          = "01707986617"
  s.fax             = "01707986617"
  s.address_city    = "Barcelona"
  s.address_zip     = "08001"
  s.address_street  = "Las Holletas"
  s.address_number  = 5
  s.address_country = "Spain"
end
