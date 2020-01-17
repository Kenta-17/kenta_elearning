class Word < ApplicationRecord
  belongs_to :category

  validates :category_id, presence: true
  validates :content, presence: true
end
