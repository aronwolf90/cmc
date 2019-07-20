# frozen_string_literal: true

IRB.conf[:IRB_RC] = proc do
  tenants = Apartment.tenant_names.sort

  if tenants.size == 1
    puts "switch to tenant #{tenants.first}"
    Apartment::Tenant.switch!(tenants.first)
  elsif tenants.size > 1
    puts "Available tenants: #{tenants.join(', ')}"

    print "Select tenant: "
    tenant = gets.strip

    unless tenant.empty?
      if tenants.include?(tenant)
        Apartment::Tenant.switch!(tenant)
      else
        puts "Tenant not found in list '#{tenant}'"
      end
    end

    puts "Tenant set to '#{Apartment::Tenant.current}'"
  end
end
