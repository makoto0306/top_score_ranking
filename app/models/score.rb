class Score < ApplicationRecord
  belongs_to :player

  validates :score, presence: true, numericality: true
  validates :time, presence: true
end
