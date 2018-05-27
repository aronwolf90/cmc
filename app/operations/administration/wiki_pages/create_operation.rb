# frozen_string_literal: true

module Administration
  module WikiPages
    class CreateOperation < AdministrationOperation
      class Present < Trailblazer::Operation
        step Model(WikiPage, :new)
        step Contract::Build(constant: WikiPageForm)
      end

      step Nested(Present)
      step Contract::Validate(key: :data)
      step Contract::Persist()
    end
  end
end
