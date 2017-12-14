class Issue::Contract < Reform::Form
  property :title
  property :description
  property :board_list_id

  validates :title, presence: true
  validates :board_list_id, presence: true
end
