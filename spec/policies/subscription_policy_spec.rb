# frozen_string_literal: true

require "rails_helper"

describe SubscriptionPolicy do
  subject { described_class }

  permissions :new?, :create? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Subscription.new)
    end

    it "grant access to the employees" do
      is_expected.not_to permit(Employee.new, Subscription.new)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, Subscription.new)
    end
  end

  permissions :edit?, :update? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Subscription.new)
    end

    it "grant access to the employees" do
      is_expected.not_to permit(Employee.new, Subscription.new)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, Subscription.new)
    end
  end

  permissions :destroy? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Subscription.new)
    end

    it "denies access to the employees" do
      is_expected.not_to permit(Employee.new, Subscription.new)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, Subscription.new)
    end
  end
end
