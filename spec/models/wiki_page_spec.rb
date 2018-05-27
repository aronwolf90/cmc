# frozen_string_literal: true

require "rails_helper"

RSpec.describe WikiPage, type: :model do
  it { is_expected.to belong_to :wiki_category  }

  context "without wiki_category" do
    it { expect { subject.save!  }.to raise_error(ActiveRecord::NotNullViolation)  }
  end
end
