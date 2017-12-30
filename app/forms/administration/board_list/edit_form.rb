module Administration
  module BoardList
    class EditForm < BaseForm
      def save
        return false if invalid?

        board_list.save!

        true
      end

      private

      def board_list
        @board_list ||= ::BoardList.new(name: name)
      end
    end
  end
end
