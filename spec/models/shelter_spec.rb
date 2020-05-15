require 'rails_helper'

RSpec.describe Shelter do
  describe "relationships" do
    it{should have_many :pets}
  end

  describe "methods" do
    it ".total_pets" do
      shelter_1 = Shelter.create(
        name: "Paws For You",
        address: "1234 W Elf Ave",
        city: "Denver",
        state: "Colorado",
        zip: "90210",
      )

      pet_1 = Pet.create(
        image: 'https://www.petful.com/wp-content/uploads/2014/01/maltese-1.jpg',
        name: "MoMo",
        approximate_age: "4",
        sex: "male",
        name_of_shelter_where_pet_is_currently_located: "Paws For You",
        shelter_id: shelter_1.id
      )

      pet_2 = Pet.create(
        image: 'https://www.petful.com/wp-content/uploads/2014/01/maltese-1.jpg',
        name: "MoMo",
        approximate_age: "4",
        sex: "male",
        name_of_shelter_where_pet_is_currently_located: "Paws For You",
        shelter_id: shelter_1.id
      )

      expect(shelter_1.total_pets).to eq(2)
    end
  end
end
