# frozen_string_literal: true

module Concerns
  module Administration
    module StandardActions
    protected
      def index(operation, cell)
        run operation
        render cell(cell, result["model"])
      end

      def new(operation, cell)
        run operation
        render cell(cell, result["contract.default"])
      end

      def create(operation, cell, path)
        saved(operation, cell, path, :created)
      end

      def edit(operation, cell)
        run operation
        render cell(cell, result["contract.default"])
      end

      def update(operation, cell, path)
        saved(operation, cell, path, :updated)
      end

      def destroy(operation, path)
        run operation
        flash[:notice] = "#{result[:model].class.model_name.human} has been destroyed"
        redirect_to path
      end

      def saved(operation, cell, path, type)
        run operation do |result|
          flash[:notice] = "#{result[:model].class.model_name.human} has been #{type}"
          return redirect_to path
        end

        render cell(cell, result["contract.default"])
      end
    end
  end
end
