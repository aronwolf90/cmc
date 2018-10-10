# frozen_string_literal: true

module Administration::Users
  class ConfigurationsController < BaseController
    namespace Administration::Users::Configurations

    public :edit

    def update
      super do |model|
        [:edit, :administration, model, :configuration]
      end
    end

    def destroy
      super(%i[administration users])
    end
  end
end
