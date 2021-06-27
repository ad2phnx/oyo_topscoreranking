class Player < ApplicationRecord
    # association
    has_many :scores, dependent: :destroy, inverse_of: :player

    # validations
    validates_presence_of :name
end
