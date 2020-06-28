# frozen_string_literal: true

require "rails_helper"

RSpec.describe GoogleCalenderClient do
  describe "#authentication_url" do
    specify do
      url = described_class.new.authentication_url

      expect(url).to include("https://")
    end
  end
end
