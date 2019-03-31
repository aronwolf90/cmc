# frozen_string_literal: true

module Administration
  module Issues
    class NewOperation < AdministrationOperation
      success :parent
      success :model
      step Policy::Pundit(IssuePolicy, :create?)
      step Contract::Build(constant: IssueForm)

      def parent(options, params:, **)
        options[:parent] = BoardList.find(params[:board_list_id])
      end

      def model(options, **)
        options[:model] = options[:parent].issues.build
      end
    end
  end
end
