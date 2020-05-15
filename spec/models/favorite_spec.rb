require "rails_helper"

RSpec.describe Favorite do
  describe ".total_count" do
    it "can calculate total number of favorites" do
      favorite = Favorite.new({1 => 1, 2 => 1})

      expect(favorite.total_count).to eq(2)
    end
  end

  describe ".add_favorite" do
    it "can add to favorites" do
    favorite = Favorite.new({'1'=> 0, '2' => 0})

    favorite.add_pet(1)
    favorite.add_pet(2)

    expect(favorite.contents).to eq({'1' => 1, '2' => 1})
    end
  end

  describe ".count_of" do
    it "can return the count of all pets in favorites" do
      favorite = Favorite.new({})
      expect(favorite.count_of(3)).to eq(0)
    end
  end
end
