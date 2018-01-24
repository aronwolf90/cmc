module Administration
  class BoardListForm
    include ActiveModel::Model

    attr_accessor :name

    validates :name, presence: true

    def self.model_name
      ::BoardList.model_name
    end

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
