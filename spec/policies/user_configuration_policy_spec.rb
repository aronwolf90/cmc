# frozen_string_literal: true

describe UserConfigurationPolicy do
  subject { described_class }

  permissions :edit?, :update? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, User)
    end

    it "grant access to the employees" do
      is_expected.not_to permit(Employee.new, User)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, User)
    end
  end
end
