# frozen_string_literal: true

describe Calenders::GoogleIntegrationPolicy do
  subject { described_class }

  permissions :destroy? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new)
    end

    it "denies access to the employees" do
      is_expected.not_to permit(Employee.new, Contact.new)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, Contact.new)
    end
  end
end
