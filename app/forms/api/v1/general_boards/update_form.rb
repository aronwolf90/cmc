# frozen_string_literal: true

module Api::V1
  module GeneralBoards
    class UpdateForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          predicates(ApiPredicates)
        end

        optional(:data).schema do
          optional(:relationships).schema do
            optional(:"board-lists").schema do
              required(:data).each do
                schema do
                  required(:id).filled
                  required(:type).filled

                  optional(:relationships).schema do
                    optional(:issues).schema(RequiredMasManySchema)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
