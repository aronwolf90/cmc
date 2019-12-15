# frozen_string_literal:true

RSpec.shared_examples "standard create operation" do
  |
    form_class:,
    valid_params: { data: {} },
    invalid_params: { data: {} },
    mutation: StandardCreateMutation
  |

  subject do
    described_class.(params: params, current_user: current_user)
  end

  let(:current_user) { Admin.new }

  before do
    allow(form_class)
      .to receive(:new).and_return(form)
    allow(mutation).to receive(:call)
  end

  context "valid params" do
    let(:params) { valid_params }
    let(:form) { double() }

    before do
      result = double(success?: true)
      allow(form).to receive(:call).and_return(result)
      allow(result).to receive(:save).and_yield(params[:data])
    end

    it { is_expected.to be_success }

    it do
      subject
      expect(mutation).to have_received(:call)
    end
  end

  context "invalid params" do
    let(:params) { invalid_params }
    let(:form) { double()  }
    let(:result) { double(success?: false) }

    before do
      allow(form).to receive(:call).and_return(result)
    end

    it { is_expected.to be_failure }

    specify do
      subject
      expect(mutation).not_to have_received(:call)
    end
  end
end
