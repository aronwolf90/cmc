# frozen_string_literal: true

module Api::V1
  module Issues
    class MoveForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        required(:issue_id).filled
        required(:before_issue_id).maybe
        required(:board_list_id).filled
      end
    end
  end
end
