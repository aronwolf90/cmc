# frozen_string_literal: true

require "rails_helper"

describe ProjectPolicy do
  subject { described_class }

  permissions :index? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Project)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, Project)
    end

    it "grant access to the customers" do
      is_expected.to permit(Customer.new, Project)
    end
  end

  permissions :new?, :create? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Project)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, Project)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, Project)
    end
  end

  permissions :edit?, :update? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Project)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, Project)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, Project)
    end
  end

  permissions :destroy? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Project)
    end

    it "denies access to the employees" do
      is_expected.not_to permit(Employee.new, Project)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, Project)
    end
  end
end

describe ProjectPolicy::Scope do
  subject { described_class.(user, Project) }

  let(:project) { create(:project) }

  context "user is admin" do
    let(:user) { Admin.new  }

    it "return all projects" do
      is_expected.to eq [project]
    end
  end

  context "user is an employee" do
    let(:user) { Employee.new  }

    it "return all projects" do
      is_expected.to eq [project]
    end
  end

  context "user is a customer" do
    let(:user) { create(:customer) }
    let(:customer_project) { create(:project)  }

    before { customer_project.users << user }

    it "return only assigned projects" do
      is_expected.to eq [customer_project]
    end
  end
end
