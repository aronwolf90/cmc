if Apartment::Tenant.current == "public"
  {
    true => %w[test-organization],
    false => %w[public]
  }[Settings.multi_tenant].each do |name|
    next if Organization.exists?(name: name)
    mutation(Organization, :create).(name: name, time_zone: "Berlin")
  end
end

if !Settings.multi_tenant || Apartment::Tenant.current != "public"
  path = Rails.root.join("db", "fixtures", Rails.env, "*.rb")

  Dir[path].sort.each do |file|
    load file
  end
end
