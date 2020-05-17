require "rails_helper"

RSpec.describe Favorite do
  before :each do
    @shelter = Shelter.create(
      name: "Paws For You",
      address: "1234 W Elf Ave",
      city: "Denver",
      state: "Colorado",
      zip: "90210",
    )

    @pet = Pet.create(
      image: 'https://www.petful.com/wp-content/uploads/2014/01/maltese-1.jpg',
      name: "MoMo",
      approximate_age: "4",
      sex: "male",
      shelter_id: @shelter.id
    )
  end
  describe "Methods" do
    it ".total_count" do
      favorite = Favorite.new({1 => 1, 2 => 1})

      expect(favorite.total_count).to eq(2)
    end

    it ".add_favorite" do
      favorite = Favorite.new({'1'=> 0, '2' => 0})

      favorite.add_pet(1)
      favorite.add_pet(2)

      expect(favorite.contents).to eq({'1' => 1, '2' => 1})
    end

    it ".count_of" do
      favorite = Favorite.new({})
      expect(favorite.count_of(3)).to eq(0)
    end

    it ".favorite_pets" do
      favorite = Favorite.new(@pet.id => 1)
      expect(favorite.favorite_pets).to eq([@pet])
    end

    it ".already_favorited?" do
      favorite = Favorite.new(@pet.id => 1)
      favorite.add_pet(@pet)
      expect(favorite.already_favorited?(@pet.id)).to eq(1)
      expect(favorite.already_favorited?(@pet.id)).to_not eq(2)
    end
  end
end
