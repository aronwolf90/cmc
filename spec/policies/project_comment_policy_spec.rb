# frozen_string_literal: true

describe ProjectCommentPolicy do
  subject { described_class }

  permissions :index? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, ProjectComment)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, ProjectComment)
    end

    it "grant access to the customers" do
      is_expected.to permit(Customer.new, ProjectComment)
    end
  end

  permissions :new?, :create? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, ProjectComment.new)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, ProjectComment.new)
    end

    it "denies access to the customers" do
      is_expected.to permit(Customer.new, ProjectComment.new)
    end
  end

  permissions :edit?, :update? do
    it "denies access to the admins" do
      is_expected.not_to permit(Admin.new, ProjectComment.new)
    end

    it "denies access to the employees" do
      is_expected.not_to permit(Employee.new, ProjectComment.new)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, ProjectComment.new)
    end

    it "admins can edit his owen comments" do
      admin = Admin.new
      is_expected.to permit(admin, ProjectComment.new(user: admin))
    end

    it "employees can edit his owen comments" do
      employee = Employee.new
      is_expected.to permit(employee, ProjectComment.new(user: employee))
    end
  end

  permissions :destroy? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, ProjectComment.new)
    end

    it "denies access to the employees" do
      is_expected.not_to permit(Employee.new, ProjectComment.new)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, ProjectComment.new)
    end
  end
end
