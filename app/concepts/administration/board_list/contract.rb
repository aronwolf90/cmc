class BoardList::Contract < Reform::Form
  property :name

  validates :name, presence: true
end
