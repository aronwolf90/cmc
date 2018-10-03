# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Projects::Records::IndexOperation do
  subject { described_class.(params: {}, current_user: user) }

  let(:user) { User.new }
  let(:project) { Project.new }

  before do
    allow(Project).to receive(:find).and_return(project)
    allow(Administration::Projects::Records::ThisMonthSpentTimeStep).to receive(:call) do |options|
      options["this_month_spended_time"] = 0
    end
  end

  it "model option is equal to record_days" do
    expect(subject["model"]).to eq([])
  end

  it "this_month_spended_time has correct value" do
    expect(subject["this_month_spended_time"]).to eq(0)
  end
end
