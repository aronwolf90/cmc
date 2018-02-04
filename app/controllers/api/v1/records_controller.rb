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
      result = Records:UpdateOperation.call(record_params)

      if result.success?
        head :ok
      else
        render_errors(result.failure)
      end
    end

    private

    def record_params
      ActiveSupport::JSON.decode(request.body.read).deep_symbolize_keys
    end

    def record
    end
  end
end
