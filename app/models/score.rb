class Score < ApplicationRecord
  # association
  belongs_to :player

  # validation
  validates_presence_of :player, :score, :time
  validates :score, numericality: { only_integer: true, greater_than: 0 }
  validates_datetime :time
end
