# frozen_string_literal: true

require "rails_helper"

RSpec.describe OrganizationSpecificTriggerJob, type: :model do
  subject { described_class.new.perform(job_clazz: CreateNotificationsJob.to_s)  }

  let!(:organization) { create(:organization) }
  let(:job) { CreateNotificationsJob }

  it "calls Jobs::CreateNotificationsOperation" do
    expect(job).to receive(:perform_later).with(organization: organization)

    subject
  end
end
