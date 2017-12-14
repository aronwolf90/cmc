require 'roar/json/json_api'

module Administration::BoardList
  class Representer < ::Roar::Decorator
    include Roar::JSON::JSONAPI.resource :board_lists
    include Rails.application.routes.url_helpers

    attributes do
      property :name
    end

    has_many :issues, extend: Administration::Issue::Representer

    link :self do
      administration_board_list_url(represented)
    end
  end
end
