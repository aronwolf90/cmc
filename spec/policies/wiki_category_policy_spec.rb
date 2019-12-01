# frozen_string_literal: true

require "rails_helper"

describe WikiCategoryPolicy do
  subject { described_class }

  permissions :index? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, WikiCategory)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, WikiCategory)
    end

    it "grant access to the customers" do
      is_expected.not_to permit(Customer.new, WikiCategory)
    end
  end

  permissions :new?, :create? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, WikiCategory)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, WikiCategory)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, WikiCategory)
    end
  end

  permissions :edit?, :update? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, WikiCategory.new)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, WikiCategory.new)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, WikiCategory.new)
    end
  end

  permissions :destroy? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, WikiCategory.new)
    end

    it "denies access to the employees" do
      is_expected.not_to permit(Employee.new, WikiCategory.new)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, WikiCategory.new)
    end
  end
end
