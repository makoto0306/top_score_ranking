class Player < ApplicationRecord
  has_many :scores
  validates :name, presence: true

  before_save :capitalize_name

  private

  def capitalize_name
    self.name = name.capitalize
  end
end
