module Api
  module V1
    class BoardListForm < BaseForm
      #clazz BoardList
      associations %i[issues]

      attributes :name, :ordinal_number

      validates :name, presence: true
      validates :ordinal_number, presence: true

      def save_relationships!
        model.board_list_issue_relations.destroy_all
        super
      end
    end
  end
end
