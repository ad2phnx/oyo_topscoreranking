class Player < ApplicationRecord
    # validations
    validates :name, presence: true, uniqueness: true, on: :create

    # association
    has_many :scores, dependent: :destroy, inverse_of: :player

    
    def top_score
        scores.maximum(:score)
    end

    def low_score
        scores.minimum(:score)
    end

    def average_score
        scores.average(:score)
    end
end
