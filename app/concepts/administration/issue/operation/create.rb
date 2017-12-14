class Administration::Issue::Create < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Issue, :new)
    step :board_list_id!
    step Contract::Build(constant: Issue::Contract)

    def board_list_id!(options, params:, **)
      options['model'].board_list_id = params[:board_list_id]
      true
    end
  end

  step Nested(Present)
  step Contract::Validate(key: :issue)
  step Contract::Persist()
end
