class DataAddGlobalBoardLists < ActiveRecord::Migration[5.1]
  def data
    return if BoardList.where(project_id: nil).present?

    open_board_list = BoardList.create!(
      name: "Open",
      kind: :open
    )

    other_board_list = BoardList.create!(
      name: "In progress",
      kind: :other
    )

    closed_board_list = BoardList.create!(
      name: "Closed",
      kind: :closed
    )

    Issue.includes(:board_list).find_each do |issue|
      case issue.board_list.kind 
      when "open"
        issue.update!(global_board_list: open_board_list)
      when "other"
        issue.update!(global_board_list: other_board_list)
      when "closed"
        issue.update!(global_board_list: closed_board_list)
      else
        raise "kind not found"
      end
    end
  end
end
