class Player < ApplicationRecord
  has_many :scores
  accepts_nested_attributes_for :scores

  validates :name, presence: true

  before_save :downcase_name

  private

  def downcase_name
    self.name = name.downcase
  end
end
