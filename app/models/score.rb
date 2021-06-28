class Score < ApplicationRecord
  # association
  belongs_to :player

  # validation
  validates_presence_of :player, :score, :time
  validates :score, numericality: { only_integer: true, greater_than: 0 }
  #validates_datetime :time

  scope :by_player, -> (players) { where(player: players.split(',')) }
  scope :after_date, -> (date) { where('time >= ?', date) }
  scope :before_date, -> (date) { where('time <= ?', date) }
end
