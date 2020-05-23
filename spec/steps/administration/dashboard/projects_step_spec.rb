# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Dashboard::ProjectsStep do
  subject { described_class.call(options, params: {}, current_user: current_user) }

  let(:current_user) { build_stubbed(:user) }
  let(:options) { {} }
  let(:record) { Record.new }
  let(:project) { Project.new }

  before do
    Timecop.freeze
    allow(RecordsUserProjectQuery)
      .to receive(:call).with(user: current_user, project: project)
      .and_return([record])
    allow(RecordsMonthUserProjectQuery)
      .to receive(:call).with(user: current_user, project: project)
      .and_return([record])
    allow(RecordsMonthUserProjectQuery).to \
      receive(:call).with(user: current_user, project: project, month: 1.month.ago)
      .and_return([])
    allow(SqlSpendedTimeCalculator)
      .to receive(:call).with([record]).and_return(3600.seconds)
    allow(SqlSpendedTimeCalculator)
      .to receive(:call).with([]).and_return(0.seconds)
    allow(Project).to receive(:ordered)
      .and_return(Kaminari.paginate_array([project], total_count: 1))
    allow(Project).to receive(:count).and_return(1)
    subject
  end

  after { Timecop.return }

  it "add projects to spent time hash to options" do
    expect(options["model"][:projects])
      .to include([project, 3600.seconds, 3600.seconds, 0])
  end
end
