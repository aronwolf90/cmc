# frozen_string_literal: true

module Api
  module V1
    module BoardLists
      class SortsController < ApiController
        def update
          result = run Api::V1::BoardLists::SortOperation

          if result.success?
            render json: result[:model], status: :no_content
          else
            render_errors(result[:errors])
          end
        end
      end
    end
  end
end
