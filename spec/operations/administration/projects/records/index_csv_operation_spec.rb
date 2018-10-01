# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Projects::Records::IndexCsvOperation do
  subject do
    described_class.(
      params: { project_id: project.id },
      current_user: user
    )
  end

  let(:user) { build_stubbed(:user) }
  let(:project) { build_stubbed(:project) }
  let(:record) { build_stubbed(:record) }

  before do
    allow(Project).to receive(:find).and_return(project)
    allow(project).to receive(:records).and_return([record])
  end

  it "model option is equal to record_days" do
    expect(subject[:model]).to eq([record])
  end
end
