require "rails_helper"

RSpec.describe Post, type: :model do
  context "associations" do
    it {expect belong_to :user}
    it {expect have_many :comments}
    it {expect have_many :post_tags}
    it {expect have_many :tags}
  end
end
