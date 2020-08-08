# frozen_string_literal: true

module AdminArea
  class OrganizationsController < AdminAreaController
    side_menu :admin_area
    namespace AdminArea::Organizations

    public :index
  end
end
