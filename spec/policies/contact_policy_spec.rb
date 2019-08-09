# frozen_string_literal: true

describe ContactPolicy do
  subject { described_class }

  permissions :index? do
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

  permissions :new?, :create? do
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

  permissions :edit?, :update? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Contact.new)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, Contact.new)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, Contact.new)
    end
  end

  permissions :destroy? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Contact.new)
    end

    it "denies access to the employees" do
      is_expected.not_to permit(Employee.new, Contact.new)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, Contact.new)
    end
  end
end
