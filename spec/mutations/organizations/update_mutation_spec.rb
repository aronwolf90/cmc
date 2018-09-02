# frozen_string_literal: true

require "rails_helper"

describe Organizations::UpdateMutation do
  subject do
    described_class.call(
      user: current_user,
      model: organization,
      **attributes,
    )
  end

  let(:organization) { create(:organization) }
  let(:current_user) { create(:admin) }
  let(:attributes) do
    {
      time_zone: "London",
    }
  end


  it "change time zone to London" do
    expect { subject }.to change(organization, :time_zone)
      .from("Berlin").to("London")
  end

  it "change time zone seconds to London" do
    expect { subject }.to change(organization, :time_zone_seconds)
      .from(7200).to(3600)
  end
end
