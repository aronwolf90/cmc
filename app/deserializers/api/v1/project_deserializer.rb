# frozen_string_literal: true

module Api::V1
  class ProjectDeserializer < ApiDeserializer
    attribute :name
    attribute :ordinal_number
    attribute :description
    map(
      from("relationships/contact/data/attributes/name"),
      to("contact_attributes/name")
    )
    map(
      from("relationships/contact/data/attributes/description"),
      to("contact_attributes/description")
    )
    map(
      from("relationships/contact/data/attributes/telephone"),
      to("contact_attributes/telephone")
    )
    map(
      from("relationships/contact/data/attributes/email"),
      to("contact_attributes/email")
    )

    belongs_to :project_status
    belongs_to :project_board_list
    belongs_to :contact
    belongs_to :main_responsable
  end
end
