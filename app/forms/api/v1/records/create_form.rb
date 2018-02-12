module Api::V1
  module Records
    class CreateForm < ApiForm
    @form = Dry::Validation.Schema do
      configure do
        predicates(ApiPredicates)
      end

      required(:data).schema do
        required(:attributes).schema do
          required(:start_time).filled
        end
        required(:relationships).schema do
          required(:user).filled(:record_exists?).schema do
            required(:data).schema do
              required(:id).filled
              required(:type).filled
            end
          end
          required(:issue).filled(:record_exists?).schema do
            required(:data).schema do
              required(:id).filled
              required(:type).filled
            end
          end
        end
      end
    end
  end
  end
end
