# frozen_string_literal: true

describe ContactAvatarPolicy do
  subject { described_class }

  permissions :create? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Contact)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, Contact)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, Contact)
    end
  end
end
