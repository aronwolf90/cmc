# frozen_string_literal: true

module Concerns
  module Administration
    module ModifyStandardActions
    protected
      def create(&block)
        saved(namespace::CreateOperation, :created, block)
      end

      def update(&block)
        saved(namespace::UpdateOperation, :updated, block)
      end

      def destroy(path)
        result = run namespace::DestroyOperation
        redirect_to path, notice: "#{model_name(result)} has been destroyed"
      end

      def saved(operation, type, block)
        run operation do |result|
          flash[:notice] = "#{model_name(result)} has been #{type}"
          return redirect_to block.call(result[:model])
        end

        render cell(namespace::Cell::Form, result["contract.default"])
      end

      def model_name(result)
        result[:model].class.model_name.human
      end
    end
  end
end
