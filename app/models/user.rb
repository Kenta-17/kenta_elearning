class User < ApplicationRecord
  before_save { email.downcase! }

  has_many :active_relationships, class_name: "Relationship",
          foreign_key: "follower_id",
          dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  
  has_many :passive_relationships, class_name:  "Relationship",
          foreign_key: "followed_id",
          dependent:   :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :lessons, dependent: :destroy
  has_many :activities, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { minimum: 3, maximum: 65 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 3 }, allow_nil: true

  mount_uploader :image, ImageUploader

  def active_relationships
    Relationship.where(follower_id: id)
    # follower_id = id  # フォローした人を探す
  end

  def passive_relationships
    Relationship.where(followed_id: id)
  end

  def followers
    ids = passive_relationships.pluck(:follower_id)
    User.where(id: ids)
  end

  def following
    ids = active_relationships.pluck(:followed_id)  # follower_id　だけ取り出す
    User.where(id: ids) # follower_id の詳細（name,emal,passwor）はUserテーブルが持っているのでそこに見に行く
  end


  def follow(other_user)  #ここでデータベースにデータを登録してる
    Relationship.create(
      follower_id: id,
      followed_id: other_user.id
    )
  end

  def relationship(other_user)
    active_relationships.find_by(
      followed_id: other_user.id
    )
  end

  # ユーザーをフォローする
  def add(other_user)
    adding << other_user
  end

  # ユーザーをフォロー解除する
  def remove(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def adding?(other_user)
    adding.include?(other_user)
  end

  def lesson_taken(cat_id)
    lesson = lessons.find_by(category_id: cat_id)
  end

end

