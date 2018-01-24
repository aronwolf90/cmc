require 'rails_helper'

describe Api::V1::IssueForm do
  context 'valid params' do
    let(:params) do
      {
        data: {
          attributes: { title: 'title', description: 'description' }
        }
      }
    end

    it 'validates form successfully' do
      form = described_class.new(Issue.new, params: params)

      expect(form.valid?).to be_truthy
    end
  end

  context 'invalid params' do
    let(:params) do
      {
        data: {
          attributes: { title: '', description: 'description' }
        }
      }
    end

    it 'validates form successfully' do
      form = described_class.new(Issue.new, params: params)

      expect(form.valid?).to be_falsey
    end
  end
end
