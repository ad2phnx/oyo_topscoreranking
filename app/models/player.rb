class Player < ApplicationRecord
    # validations
    validates :name, presence: true, uniqueness: true, on: :create

    # association
    has_many :scores, dependent: :destroy, inverse_of: :player
end
