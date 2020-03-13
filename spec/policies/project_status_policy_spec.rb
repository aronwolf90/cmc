# frozen_string_literal: true

describe ContactPolicy do
  subject { described_class }

  permissions :index? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, ProjectStatus)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, ProjectStatus)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, ProjectStatus)
    end
  end
end
