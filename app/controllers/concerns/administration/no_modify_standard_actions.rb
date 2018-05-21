# frozen_string_literal: true

module Concerns
  module Administration
    module NoModifyStandardActions
    protected

      def index
        result = run namespace::IndexOperation
        render cell(namespace::Cell::Index, result["model"])
      end

      def new
        result = run namespace::CreateOperation::Present
        render cell(namespace::Cell::Form, result["contract.default"])
      end

      def show
        result = run namespace::ShowOperation
        render cell(namespace::Cell::Show, result["model"])
      end

      def edit
        result = run namespace::UpdateOperation::Present
        render cell(namespace::Cell::Form, result["contract.default"])
      end
    end
  end
end
