module Administration::Board
  class Update < Trailblazer::Operation
    extend Trailblazer::Operation::Representer::DSL

    step :vaidate
    step Contract::Validate(representer: Representer)
    step :persist!

    def persist!(options, *)
      Administration::BoardList::Representer.prepare(::BoardList.first).from_json(Administration::BoardList::Representer.prepare(::BoardList.first).to_json)
    end
  end
end
