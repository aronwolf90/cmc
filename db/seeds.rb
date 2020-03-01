# frozen_string_literal: true

if Apartment::Tenant.current == "public" && Organization.none?
  {
    true => %w[test-organization],
    false => %w[public]
  }[Settings.multi_tenant].each do |name|
    next if Organization.exists?(name: name)

    mutation(Organization, :create).call(name: name, time_zone: "Berlin", subscription_id: 1)
  end
end

if !Settings.multi_tenant || Apartment::Tenant.current != "public"
  shared_path = Rails.root.join("db", "fixtures", "shared", "*.rb")
  path = Rails.root.join("db", "fixtures", ENV["SEEDS_FOLDER"] || Rails.env, "*.rb")

  Dir[shared_path].sort.each do |file|
    load file
  end

  Dir[path].sort.each do |file|
    load file
  end
end
