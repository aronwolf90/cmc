class GeneralBoard < ActiveModelSerializers::Model
  def board_lists
    @board_lists ||= BoardList.all.order(:ordinal_number)
  end
end
