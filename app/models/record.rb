# frozen_string_literal: true

class Record < ApplicationRecord
  belongs_to :user
  belongs_to :issue

  alias_attribute :inactive?, :end_time?
end
