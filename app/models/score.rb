class Score < ApplicationRecord
  # association
  belongs_to :player

  # validation
  validates_presence_of :score, :time
end
