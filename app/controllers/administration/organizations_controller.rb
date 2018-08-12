# frozen_string_literal: true

module Administration
  class OrganizationsController < AdministrationController
    side_menu "administration/organization"
    namespace Organizations

    def edit
      super
    end

    def update
      super { %i[edit administration organization] }
    end
  end
end
