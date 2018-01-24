require 'rails_helper'

describe Api::V1::Issues::UpdateService do
  let(:issue) { create(:issue, title: 'title_before') }
  let(:params) do
    {
      data: {
        attributes: { title: 'title_after', description: 'description' }
      }
    }
  end

  it 'issue is updated' do
    service = described_class.new(issue, params: params)

    expect do
      service.perform
    end.to change{ issue.title }.from('title_before').to('title_after')
  end
end
