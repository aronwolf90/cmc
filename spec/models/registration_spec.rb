# frozen_string_literal: true

require "rails_helper"

RSpec.describe Registration, type: :model do
  subject { described_class.new(attributes) }

  let(:attributes) do
    {
      "name" => "name",
      "time_zone" => "Berlin",
      "firstname" => "Tomb",
      "lastname" => "Raider",
      "email" => "romb@email.com",
      "password" => "testtest"
    }
  end

  it "has the required attributes" do
    expect(subject.as_json).to eq(attributes)
  end
end
