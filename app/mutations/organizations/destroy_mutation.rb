# frozen_string_literal: true

module Organizations
  class DestroyMutation < StandardDestroyMutation
    def call
      ActiveRecord::Base.transaction do
        ActiveRecord::Base.connection.schema_exists?(model.name) &&
          Apartment::Tenant.drop(model.name)

        model.destroy!
      end
      (ActiveRecord::Base.connection.tables - %w[schema_migrations versions]).each do |table|
        table.classify.constantize.reset_column_information rescue nil
      end
    end
  end
end
