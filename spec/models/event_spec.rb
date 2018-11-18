# frozen_string_literal: true

require "rails_helper"

RSpec.describe Event, type: :model do
  describe "#to_s" do
    it { expect(Event.new(title: "title").to_s).to eq "title"   }
  end
end
