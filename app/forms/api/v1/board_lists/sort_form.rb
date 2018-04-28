# frozen_string_literal: true


module Api::V1
  module BoardLists
    class SortForm < ApiForm
      @form = Dry::Validation.Schema do
        configure do
          config.messages_file = Rails.root.join("config", "locales", "errors.yml")

          def board_list_exists?(id)
            BoardList.find_by(id: id).present?
          end
        end

        required(:data).filled { each(:board_list_exists?) }
      end
    end
  end
end
