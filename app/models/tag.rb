class Tag < ApplicationRecord
  has_many :post_tags
  has_many :posts, through: :post_tags

  validates :name, presence: true,
    length: {maximum: Settings.tag.name.max_length}
end
