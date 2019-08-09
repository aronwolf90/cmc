# frozen_string_literal: true

class Contact < ApplicationRecord
  belongs_to :contact_avatar

  pg_search_scope :search, against: %i[id name]
end
