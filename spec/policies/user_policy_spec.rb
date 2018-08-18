# frozen_string_literal: true

describe UserPolicy do
  subject { described_class }

  permissions :index? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Project)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, Project)
    end

    it "grant access to the customers" do
      is_expected.to permit(Customer.new, Project)
    end
  end

  permissions :new?, :create? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Project)
    end

    it "grant access to the employees" do
      is_expected.not_to permit(Employee.new, Project)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, Project)
    end
  end

  permissions :edit?, :update? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Project)
    end

    it "grant access to the employees" do
      is_expected.not_to permit(Employee.new, Project)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, Project)
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
