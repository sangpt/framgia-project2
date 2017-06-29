require "rails_helper"

RSpec.describe Relationship, type: :model do
  context "associations" do
    it {expect belong_to :follower}
    it {expect belong_to :followed}
  end
end
