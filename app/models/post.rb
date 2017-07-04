class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :post_tags
  has_many :tags, through: :post_tags

  scope :post_sort, ->{order created_at: :desc}

  validates :title, presence: true,
    length: {maximum: Settings.post.title.max_length}
  validates :user, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.post.content.max_length}
end
