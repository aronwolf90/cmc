# frozen_string_literal: true

module Administration::Users
  class ConfigurationsController < BaseController
    namespace Administration::Users::Configurations

    public :edit

    def update
      super { { action: :edit } }
    end

    def destroy
      super(%i[administration users])
    end
  end
end
