class AddDeefaultKindToBoardLists < ActiveRecord::Migration[5.1]
  def up
    change_data
    change_column :board_lists, :kind, :board_list_kind_enum, null: false, default: "other"
  end

  def down; end

  def change_data
    first_open_board_list = BoardList.where(project_id: nil).open.first
    first_closed_board_list = BoardList.where(project_id: nil).closed.first

    BoardList
      .where(project_id: nil)
      .open
      .where
      .not(id: first_open_board_list&.id)
      .update_all(kind: "other")
    BoardList
      .where(project_id: nil)
      .closed
      .where
      .not(id: first_closed_board_list&.id)
      .update_all(kind: "other")
    BoardList
      .where(project_id: nil, kind: nil)
      .update_all(kind: "other")

    BoardList.where.not(project_id: nil).map(&:project).each do |project|
      first_open_board_list = project.board_lists.open.first
      first_closed_board_list = project.board_lists.closed.first

      project
        .board_lists
        .open
        .where
        .not(id: first_open_board_list&.id)
        .update_all(kind: "other")
      project
        .board_lists
        .closed
        .where
        .not(id: first_closed_board_list&.id)
        .update_all(kind: "other")
      project
        .board_lists
        .where(kind: nil)
        .update_all(kind: "other")
    end
  end
end
