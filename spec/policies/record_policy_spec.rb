# frozen_string_literal: true

require "rails_helper"

describe RecordPolicy do
  subject { described_class }

  permissions :index? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Record)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, Record)
    end

    it "grant access to the customers" do
      is_expected.to permit(Customer.new, Record)
    end
  end

  permissions :new?, :create? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Record)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, Record)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, Record)
    end
  end

  permissions :edit?, :update? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Record.new)
    end

    it "denies access to the employees" do
      is_expected.to permit(Employee.new, Record.new)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, Record.new)
    end

    it "employees can self update his records" do
      employee = Employee.new
      is_expected.to permit(employee, Record.new(user: employee))
    end
  end

  permissions :destroy? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Record.new)
    end

    it "denies access to the employees" do
      is_expected.not_to permit(Employee.new, Record.new)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, Record.new)
    end

    it "employees can remove his owen records" do
      employee = Employee.new
      is_expected.to permit(employee, Record.new(user: employee))
    end
  end
end
