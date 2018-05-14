# frozen_string_literal: true

module Administration
  module Issues
    class CreateOperation < AdministrationOperation
      class Present < Trailblazer::Operation
        step Model(::Issue, :new)
        step :assigen_board_list!
        step Contract::Build(constant: IssueForm)

        def assigen_board_list!(options, params:, **args)
          options[:model].board_list = ::BoardList.find(params[:board_list_id])
        end
      end

      step Nested(Present)
      step Contract::Validate(key: :data)
      step Contract::Persist()
    end
  end
end
