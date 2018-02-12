# frozen_string_literal: true

module Api::V1
  class RecordsController < ApiController
    def create
      result = Records::CreateTransacion.call(record_params)

      if result.success?
        render json: result.success, status: :created
      else
        render_errors(result.failure)
      end
    end

    def update
      result = Records::UpdateTransaction.call(params: record_params, record: record)

      if result.success?
        head :no_content
      else
        render_errors(result.failure)
      end
    end

  private

    def record_params
      ActiveSupport::JSON.decode(request.body.read).deep_symbolize_keys
    end

    def record
      @record ||= Record.find(params[:id])
    end
  end
end
