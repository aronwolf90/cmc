# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Dashboard::ProjectsStep do
  subject { described_class.call(options, params: {}, current_user: current_user) }

  let(:current_user) { build_stubbed(:user) }
  let(:options) { {} }
  let(:record) { build_stubbed(:record) }
  let(:project) { build_stubbed(:project) }

  before do
    allow(RecordsUserProjectQuery).to receive(:call).and_return([record])
    allow(SpentTimeCalculator).to receive(:call).with([record]).and_return(3600.seconds)
    allow(SpentTimeCalculator).to receive(:call).with([]).and_return(0.seconds)
    allow(RecordsWithoutProjectQuery).to receive(:call).and_return([])
    allow(Project).to receive(:find_each).and_yield(project)
    subject
  end

  it "add projects to spent time hash to options" do
    expect(options["model"][:projects]).to include(project => 3600.seconds)
  end

  it "add general project to spent time hash to options" do
    expect(options["model"][:projects]).to include(OpenStruct.new(name: "General project") => 0.seconds)
  end
end
