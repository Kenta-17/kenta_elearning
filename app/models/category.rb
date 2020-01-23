class Category < ApplicationRecord
  has_many :words, dependent: :destroy

  has_many :lessons, dependent: :destroy

  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 3, maximum: 100 }

  def active_words
    Word.where(category_id: id)
  end
end
