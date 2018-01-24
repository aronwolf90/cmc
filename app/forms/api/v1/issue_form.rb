module Api
  module V1
    class IssueForm < BaseForm
      associations []

      attributes :title, :description, :user_id

      validates :title, presence: true, if: ->{ params_contains?(:title) }
      validates :description, presence: true, if: ->{ params_contains?(:description) }
      validates :user_id, presence: true, if: ->{ params_contains?(:issue_id) }
    end
  end
end
