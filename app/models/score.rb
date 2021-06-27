class Score < ApplicationRecord
  # association
  belongs_to :player

  # validation
  validates_presence_of :score, :time
  validates :score, numericality: { only_integer: true, greater_than: 0 }
end
