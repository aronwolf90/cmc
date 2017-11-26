module User::Contract
  class Update < Reform::Form
    property :email
    property :firstname
    property :lastname

    validates :firstname, presence: true
    validates :lastname,  presence: true
  end
end
