# frozen_string_literal: true

module Administration
  module Users
    class UpdateOperation < AdministrationOperation
      class Present < Trailblazer::Operation
        step Model(User, :find)
        step Contract::Build(constant: UserForm)
      end

      step Nested(Present)
      step Contract::Validate(key: :data)
      step Contract::Persist()
    end
  end
end
