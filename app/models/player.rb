class Player < ApplicationRecord
  has_many :scores
  validates :name, presence: true

  before_save :capitalize_name

  def average_score
    #scores.sum { |s| s.score } * 1.0 / scores.count
    scores.average(:score)
  end


  private

  def capitalize_name
    self.name = name.capitalize
  end
end
