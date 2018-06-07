# frozen_string_literal: true

module Administration
  module Records
    class CreateOperation < AdministrationOperation
      class Present < Trailblazer::Operation
        step Model(Record, :new)
        step Contract::Build(constant: RecordForm)
      end

      success :set_user
      success Nested(Present)
      step Contract::Validate(key: :data)
      success CreateMutationStep.new(mutation: ::Records::CreateMutation)

      def set_user(options, current_user:, **)
        options[:params][:data][:user_id] = current_user.id
      end
    end
  end
end
