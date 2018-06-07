# frozen_string_literal: true

module Administration
  module Records
    class UpdateOperation < AdministrationOperation
      class Present < Trailblazer::Operation
        step Model(Record, :find)
        step Contract::Build(constant: RecordForm)
      end

      success Nested(Present)
      step Contract::Validate(key: :data)
      success UpdateMutationStep.new(mutation: ::Records::UpdateMutation)
    end
  end
end
