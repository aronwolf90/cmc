# frozen_string_literal: true

require "rails_helper"

describe EventPolicy do
  subject { described_class }

  permissions :index? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Event)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, Event)
    end

    it "grant access to the customers" do
      is_expected.to permit(Customer.new, Event)
    end
  end

  permissions :new?, :create? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Event)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, Event)
    end

    it "denies access to the customers" do
      is_expected.to permit(Customer.new, Event)
    end
  end

  permissions :edit?, :update? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Event.new)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, Event.new)
    end

    it "denies access to the customers" do
      is_expected.to permit(Customer.new, Event.new)
    end
  end

  permissions :destroy? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Event.new)
    end

    it "denies access to the employees" do
      is_expected.not_to permit(Employee.new, Event.new)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, Event.new)
    end
  end
end
