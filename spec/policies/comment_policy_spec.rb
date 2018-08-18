# frozen_string_literal: true

describe CommentPolicy do
  subject { described_class }

  permissions :index? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Comment)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, Comment)
    end

    it "grant access to the customers" do
      is_expected.to permit(Customer.new, Comment)
    end
  end

  permissions :new?, :create? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, Comment)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, Comment)
    end

    it "denies access to the customers" do
      is_expected.to permit(Customer.new, Comment)
    end
  end

  permissions :edit?, :update? do
    it "denies access to the admins" do
      is_expected.not_to permit(Admin.new, Comment.new)
    end

    it "denies access to the employees" do
      is_expected.not_to permit(Employee.new, Comment.new)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, Comment.new)
    end

    it "admins can edit his owen comments" do
      admin = Admin.new
      is_expected.to permit(admin, Comment.new(user: admin))
    end

    it "employees can edit his owen comments" do
      employee = Employee.new
      is_expected.to permit(employee, Comment.new(user: employee))
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
