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

  describe ".favorite_pets" do
    it "can return the id of favorite pet" do
      shelter_1 = Shelter.create(
        name: "Paws For You",
        address: "1234 W Elf Ave",
        city: "Denver",
        state: "Colorado",
        zip: "90210",
      )

      pet = Pet.create(
        image: 'https://www.petful.com/wp-content/uploads/2014/01/maltese-1.jpg',
        name: "MoMo",
        approximate_age: "4",
        sex: "male",
        shelter_id: shelter_1.id
      )

      favorite = Favorite.new(pet.id => 1)
      expect(favorite.favorite_pets).to eq([pet])
    end
  end
end
