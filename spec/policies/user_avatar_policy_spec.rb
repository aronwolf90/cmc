# frozen_string_literal: true

describe UserAvatarPolicy do
  subject { described_class }

  permissions :create? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, UserAvatar)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, UserAvatar)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, UserAvatar)
    end
  end
end
