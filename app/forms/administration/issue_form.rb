module Administration
  class IssueForm 
    include ActiveModel::Model

    attr_accessor :title, :description, :board_list_id

    validates :title, presence: true
    validates :board_list_id, presence: true

    def self.model_name
      ::Issue.model_name
    end

    def save
      return false if invalid?

      ActiveRecord::Base.transaction do
        issue.save!
        board_list_issue_relation.save!
      end

      true
    end

    private

    def issue
      @issue ||= ::Issue.new(title: title, description: description)
    end

    def board_list_issue_relation
      @board_list_issue_relation ||=
        issue.board_list_issue_relations.build(board_list: board_list)
    end

    def board_list
      @board_list ||= ::BoardList.find(board_list_id)
    end
  end
end
