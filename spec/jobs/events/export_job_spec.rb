# frozen_string_literal: true

require "rails_helper"

RSpec.describe Events::ExportJob, type: :model do
  subject(:perform) { described_class.perform_now(organization, event.id) }

  let(:organization) { Organization.new }
  let(:event) { Event.new(id: 1) }

  before do
    allow(Events::ExportOperation).to receive(:call)
    allow(Event).to receive(:find).and_return(event)
  end

  it "calls Jobs::CreateNotificationsOperation" do
    perform
    expect(Events::ExportOperation).to have_received(:call)
  end
end
