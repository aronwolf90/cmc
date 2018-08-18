# frozen_string_literal: true

describe DocumentPolicy do
  subject { described_class }

  permissions :index? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Document)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, Document)
    end

    it "grant access to the customers" do
      is_expected.not_to permit(Customer.new, Document)
    end
  end

  permissions :new?, :create? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Document)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, Document)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, Document)
    end
  end

  permissions :edit?, :update? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Document.new)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, Document.new)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, Document.new)
    end
  end

  permissions :destroy? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Document.new)
    end

    it "denies access to the employees" do
      is_expected.not_to permit(Employee.new, Document.new)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, Document.new)
    end
  end
end
