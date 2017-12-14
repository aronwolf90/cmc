require 'roar/json/json_api'

module Administration::Issue
  class Representer < ::Roar::Decorator
    include Roar::JSON::JSONAPI.resource :issue
    include Rails.application.routes.url_helpers

    attributes do
      property :title
    end

    link :self do
      administration_issue_url(represented)
    end
  end
end
