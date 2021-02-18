# frozen_string_literal: true

require "rails_helper"

describe IssuePolicy do
  subject { described_class }

  permissions :index? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Issue)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, Issue)
    end

    it "grant access to the customers" do
      is_expected.to permit(Customer.new, Issue)
    end
  end

  permissions :new?, :create? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Issue)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, Issue)
    end

    it "denies access to the customers" do
      is_expected.to permit(Customer.new, Issue)
    end
  end

  permissions :edit?, :update?, :move? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Issue.new)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, Issue.new)
    end

    it "denies access to the customers" do
      is_expected.to permit(Customer.new, Issue.new)
    end
  end

  permissions :destroy? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Issue.new)
    end

    it "denies access to the employees" do
      is_expected.to permit(Employee.new, Issue.new)
    end

    it "denies access to the customers" do
      is_expected.to permit(Customer.new, Issue.new)
    end
  end
end
