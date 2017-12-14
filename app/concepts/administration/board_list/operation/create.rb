class Administration::BoardList::Create < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(BoardList, :new)
    step Contract::Build(constant: BoardList::Contract)
  end

  step Nested(Present)
  step Contract::Validate(key: :board_list)
  step Contract::Persist()
end
