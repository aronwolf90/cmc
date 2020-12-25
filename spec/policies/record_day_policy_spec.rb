# frozen_string_literal: true

require "rails_helper"

describe RecordDayPolicy do
  subject { described_class }

  permissions :index? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, RecordDay)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, RecordDay)
    end

    it "grant access to the customers" do
      is_expected.to permit(Customer.new, RecordDay)
    end
  end

  permissions :new?, :create? do
    it "grant access to the admins" do
      is_expected.not_to permit(Admin.new, RecordDay)
    end

    it "grant access to the employees" do
      is_expected.not_to permit(Employee.new, RecordDay)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, RecordDay)
    end
  end

  permissions :edit?, :update? do
    it "grant access to the admins" do
      is_expected.not_to permit(Admin.new, RecordDay.new)
    end

    it "denies access to the employees" do
      is_expected.not_to permit(Employee.new, RecordDay.new)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, RecordDay.new)
    end

    it "employees can self update his records" do
      is_expected.not_to permit(Employee.new, RecordDay.new)
    end
  end

  permissions :destroy? do
    it "grant access to the admins" do
      is_expected.not_to permit(Admin.new, RecordDay.new)
    end

    it "denies access to the employees" do
      is_expected.not_to permit(Employee.new, RecordDay.new)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, RecordDay.new)
    end

    it "employees can remove his owen records" do
      is_expected.not_to permit(Employee.new, RecordDay.new)
    end
  end
end
