class Category < ApplicationRecord
  has_many :words, dependent: :destroy

  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 3, maximum: 100 }

  def active_words
    Word.where(category_id: id)
    # follower_id = id  # フォローした人を探す
  end
end
