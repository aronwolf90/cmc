# frozen_string_literal: true

Contact.bulk_insert(
  :id,
  :project_id,
  :name,
  :email,
  :description,
  :telephone,
  :mobile,
  :fax,
  :address_city,
  :address_zip,
  :address_street,
  :address_number,
  :address_country,
  :created_at,
  :updated_at
) do |worker|
  worker.add(
    id: 1,
    name: "Clara",
    email: "clara@test.example",
    description: "Test description",
    telephone: "01707986607",
    mobile: "01707986617",
    fax: "01707986617",
    address_city: "Barcelona",
    address_zip: "08001",
    address_street: "Las Holletas",
    address_number: 5,
    address_country: "Spain",
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 2,
    project_id: 1,
    name: "Project",
    email: "clara@test.example",
    description: "Test description",
    telephone: "01707986607",
    mobile: "01707986617",
    fax: "01707986617",
    address_city: "Barcelona",
    address_zip: "08001",
    address_street: "Las Holletas",
    address_number: 5,
    address_country: "Spain",
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )
end
