# frozen_string_literal: true

describe AdminPolicy do
  subject { described_class }

  permissions :edit?, :update? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, User.new)
    end

    it "grant access to the employees" do
      is_expected.not_to permit(Employee.new, User.new)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, User.new)
    end

    it "employees can self edit" do
      employee = Employee.new
      is_expected.to permit(employee, employee)
    end

    it "customers can self edit" do
      customer = Customer.new
      is_expected.to permit(customer, customer)
    end
  end

  permissions :destroy? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Project)
    end

    it "denies access to the employees" do
      is_expected.not_to permit(Employee.new, Project)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, Project)
    end
  end
end
