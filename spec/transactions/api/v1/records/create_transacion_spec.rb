require 'rails_helper'

describe Api::V1::Records::CreateTransacion do
  subject { described_class.call(params) }

  let(:start_time) { Time.zone.now }
  let(:params) do
    {
      data: {
        attributes: {
          start_time: start_time
        },
        relationships: {
          user: { data: { id: 1, type: 'users' }},
          issue: { data: { id: 1, type: 'issues' }}
        }
      }
    }
  end

  before do
    allow(Api::V1::Records::CreateForm).to receive(:call).and_return(double('success?': true))
    allow(Api::V1::Records::CreateDeserializer).to receive(:normalize).and_return(start_time: Time.zone.now, user_id: 1, issue_id: 1)
    allow(Record).to receive(:create!)
  end

  it 'correct classes have been called' do
    expect(Api::V1::Records::CreateForm).to receive(:call)
    expect(Api::V1::Records::CreateDeserializer).to receive(:normalize)
    expect(Record).to receive(:create!)

    subject
  end
end
