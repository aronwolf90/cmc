# frozen_string_literal: true

module Organizations
  class DestroyMutation < StandardDestroyMutation
    def call
      ActiveRecord::Base.transaction do
        ActiveRecord::Base.connection.schema_exists?(model.name) &&
          Apartment::Tenant.drop(model.name)

        model.destroy!
      end
    end
  end
end
