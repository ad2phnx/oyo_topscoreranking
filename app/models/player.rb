class Player < ApplicationRecord
    # association
    has_many :scores, dependent: :destroy

    # validations
    validates_presence_of :name
end
