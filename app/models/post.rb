class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :post_tags
  has_many :tags, through: :post_tags

  scope :post_sort, ->{order created_at: :desc}
  scope :load_feed, -> id do
    following_ids = "SELECT followed_id FROM relationships
      WHERE  follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})
      OR user_id = :user_id", user_id: id)
  end

  mount_uploader :picture, PictureUploader

  validates :title, presence: true,
    length: {maximum: Settings.post.title.max_length}
  validates :user, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.post.content.max_length}
end
