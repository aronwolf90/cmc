# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::TestOrganizations::CreateOperation do
  subject do
    described_class.(
      params: { user_id: user.id },
      current_user: current_user
    )
  end
  let(:user) { User.new(id: 1) }
  let(:current_user) { Admin.new }

  before do
    allow(Api::V1::TestOrganizationDeserializer)
      .to receive(:normalize)
      .and_return({})

    allow(::TestOrganizations::CreateMutation)
      .to receive(:call)
  end

  it "calls create mutation" do
    subject
    expect(::TestOrganizations::CreateMutation)
      .to have_received(:call)
  end
end
