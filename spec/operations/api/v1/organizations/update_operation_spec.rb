# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::Organizations::UpdateOperation do
  subject { described_class.(current_user: Admin.new, params: {}) }

  specify do
    allow(Organization).to receive(:current).and_return(Organization.new)
    allow(Api::V1::Organizations::UpdateForm)
      .to receive(:call)
      .and_return(OpenStruct.new(errors: []))
    allow(Api::V1::OrganizationDeserializer)
      .to receive(:call)
      .and_return({})
    expect(Organizations::UpdateMutation).to receive(:call)

    subject
  end
end
