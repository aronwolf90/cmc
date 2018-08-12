def create_organization?(name)
  ENV["RAILS_ENV"] == "development" &&
    Organization.find_by(name: name).nil?
end

def create_organization(name)
  Organization.create name: name
  Apartment::Tenant.create(name) if Settings.multi_tenant
end

if Apartment::Tenant.current == "public"
  %w[test-organization].each do |name|
    create_organization(name) if create_organization?(name)
  end
end

if !Settings.multi_tenant || Apartment::Tenant.current != "public"
  Rake::Task["db:seed_fu"].invoke
end
