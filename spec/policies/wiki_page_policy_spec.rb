# frozen_string_literal: true

describe WikiPagePolicy do
  subject { described_class }

  permissions :index? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, WikiPage)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, WikiPage)
    end

    it "grant access to the customers" do
      is_expected.not_to permit(Customer.new, WikiPage)
    end
  end

  permissions :new?, :create? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, WikiPage)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, WikiPage)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, WikiPage)
    end
  end

  permissions :edit?, :update? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, WikiPage.new)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, WikiPage.new)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, WikiPage.new)
    end
  end

  permissions :destroy? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, WikiPage.new)
    end

    it "denies access to the employees" do
      is_expected.not_to permit(Employee.new, WikiPage.new)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, WikiPage.new)
    end
  end
end
