# frozen_string_literal: true

describe ProjectBoardListPolicy do
  subject { described_class }

  permissions :index? do
    it "grant access to the admins" do
      is_expected.to permit(Admin.new, ProjectStatus)
    end

    it "grant access to the employees" do
      is_expected.to permit(Employee.new, ProjectStatus)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, ProjectStatus)
    end
  end

  permissions :destroy? do
    it "allow to the admins" do
      is_expected.to permit(Admin.new, ProjectStatus.new)
    end

    it "allow to the employees" do
      is_expected.to permit(Employee.new, ProjectStatus.new)
    end

    it "denies access to the customers" do
      is_expected.not_to permit(Customer.new, ProjectStatus.new)
    end

    context "when is has projects" do
      let(:project_status) { ProjectStatus.new }

      before do
        allow(project_status.projects)
          .to receive(:exists?).and_return true
      end

      it "denies action to the admins" do
        is_expected.not_to permit(Admin.new, project_status)
      end

      it "denies action to the employees" do
        is_expected.not_to permit(Employee.new, project_status)
      end

      it "denies action to the customers" do
        is_expected.not_to permit(Customer.new, project_status)
      end
    end
  end
end
