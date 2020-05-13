require "rails_helper"

RSpec.describe Favorite do
  describe "total_count" do
    it "can calculate total number of favorites" do
      favorite = Favorite.new({1 => 2, 2 => 3})

      expect(favorite.total_count).to eq(5)
    end
  end
end
