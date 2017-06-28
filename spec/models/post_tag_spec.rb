require "rails_helper"

RSpec.describe PostTag, type: :model do
  context "associations" do
    it {expect belong_to :post}
    it {expect belong_to :tag}
  end
end
