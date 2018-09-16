# frozen_string_literal: true

module Administration
  class RecordsController < AdministrationController
    include RecordsControllerConcern
    side_menu :administration
    namespace Administration::Records

    public :index, :new, :edit

    def create
      super { [:administration, :records] }
    end

    def update
      super { [:administration, :records] }
    end

    def destroy
      super(%i[administration records])
    end
  end
end
