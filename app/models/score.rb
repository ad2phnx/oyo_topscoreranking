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

  def after_save
    self.update_history
  end
  def after_destroy
    self.update_history
  end
  def update_history
    self.player.top_score = self.player.scores.maximum(:score)
    self.player.low_score = self.player.scores.minimum(:score)
    self.player.average_score = self.player.scores.average(:score)
    self.score.save
  end
end
