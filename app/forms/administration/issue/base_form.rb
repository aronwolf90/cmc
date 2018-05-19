# frozen_string_literal: true

module Administration
  module Issue
    class BaseForm
      include ActiveModel::Model

      attr_accessor :title, :description, :board_list_id

      validates :title, presence: true
      validates :description, presence: true
      validates :board_list_id, presence: true

      def self.model_name
        ::Issue.model_name
      end
    end
  end
end
