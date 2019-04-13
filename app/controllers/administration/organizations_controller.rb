# frozen_string_literal: true

module Administration
  class OrganizationsController < AdministrationController
    side_menu "administration/organization"
    namespace Administration::Organizations

    public :edit

    def update
      super { %i[edit administration organization] }
    end
  end
end
