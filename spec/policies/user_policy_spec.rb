# frozen_string_literal: true

require "rails_helper"

describe UserPolicy do
  subject { described_class }

  permissions :index? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, User)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, User)
    end

    it "grant access to the customers" do
      is_expected.to permit(Customer.new, User)
    end
  end

  permissions :new?, :create? do
    context "when premium? == true" do
      before { allow(Organization).to receive(:premium?).and_return(true) }

      it "grant access to the admins" do
        is_expected.to permit(Admin.new, User)
      end

      it "grant access to the employees" do
        is_expected.not_to permit(Employee.new, User)
      end

      it "denies access to the customers" do
        is_expected.not_to permit(Customer.new, User)
      end
    end

    context "when premium? == false and User.count < 10" do
      before do
        allow(Organization).to receive(:premium?).and_return(false)
        allow(User).to receive(:count).and_return(4)
      end

      it "grant access to the admins" do
        is_expected.to permit(Admin.new, User)
      end

      it "grant access to the employees" do
        is_expected.not_to permit(Employee.new, User)
      end

      it "denies access to the customers" do
        is_expected.not_to permit(Customer.new, User)
      end
    end

    context "when premium? == false and User.count == 10" do
      before do
        allow(Organization).to receive(:premium?).and_return(false)
        allow(User).to receive(:count).and_return(10)
      end

      it "grant access to the admins" do
        is_expected.not_to permit(Admin.new, User)
      end

      it "grant access to the employees" do
        is_expected.not_to permit(Employee.new, User)
      end

      it "denies access to the customers" do
        is_expected.not_to permit(Customer.new, User)
      end
    end

    context "when premium? == false and User.count > 10" do
      before do
        allow(Organization).to receive(:premium?).and_return(false)
        allow(User).to receive(:count).and_return(11)
      end

      it "grant access to the admins" do
        is_expected.not_to permit(Admin.new, User)
      end

      it "grant access to the employees" do
        is_expected.not_to permit(Employee.new, User)
      end

      it "denies access to the customers" do
        is_expected.not_to permit(Customer.new, User)
      end
    end
  end

  permissions :edit?, :update? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, User)
    end

    it "grant access to the employees" do
      is_expected.not_to permit(Employee.new, User)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, User)
    end
  end

  permissions :destroy? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, User)
    end

    it "denies access to the employees" do
      is_expected.not_to permit(Employee.new, User)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, User)
    end
  end
end
