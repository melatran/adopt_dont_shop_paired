require 'rails_helper'

RSpec.describe Shelter do
  before :each do
    @shelter_1 = Shelter.create(
      name: "Paws For You",
      address: "1234 W Elf Ave",
      city: "Denver",
      state: "Colorado",
      zip: "90210",
    )

    @pet_1 = Pet.create(
      image: 'https://www.petful.com/wp-content/uploads/2014/01/maltese-1.jpg',
      name: "MoMo",
      approximate_age: "4",
      sex: "male",
      name_of_shelter_where_pet_is_currently_located: "Paws For You",
      shelter_id: @shelter_1.id
    )

    @pet_2 = Pet.create(
      image: 'https://www.petful.com/wp-content/uploads/2014/01/maltese-1.jpg',
      name: "MoMo",
      approximate_age: "4",
      sex: "male",
      name_of_shelter_where_pet_is_currently_located: "Paws For You",
      shelter_id: @shelter_1.id
    )
  end
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  describe "relationships" do
    it{should have_many :pets}
  end

  describe "methods" do
    it ".total_pets" do
      expect(@shelter_1.total_pets).to eq(2)
    end

    it ".average_rating" do
      review1 = @shelter_1.reviews.create!(title:"Claws for you",rating: 2,content: "I have never left a place with so many scratches.")

      review2 = @shelter_1.reviews.create!(title:"Pew Pew",rating: 4,content: "Cute pets available.")

      review3 = @shelter_1.reviews.create!(title:"Buddy and Me",rating: 4,content: "Found my new best friend")

      expect(@shelter_1.average_rating).to eq(3.3333333333333335)
    end

    it ".total_applications" do
      jae = Application.create(
        name: "Jae Park",
        address: "1245 S Ahgase Way",
        city: "Arcadia",
        state: "CA",
        zip: "910023",
        phone_number: "626-111-1111",
        description: "I love pets"
      )

      toph = Application.create(
        name: "Toph Appa",
        address: "1245 S Way",
        city: "Denver",
        state: "C)",
        zip: "80013",
        phone_number: "306-111-1111",
        description: "I love dogs."
      )

      PetApplication.create(pet_id: @pet_1.id, application_id: jae.id)
      PetApplication.create(pet_id: @pet_2.id, application_id: toph.id)

      expect(@shelter_1.total_applications).to eq(2)
    end
  end

  it "can give the boolean value if there are pending pets" do
    jae = Application.create(
      name: "Jae Park",
      address: "1245 S Ahgase Way",
      city: "Arcadia",
      state: "CA",
      zip: "910023",
      phone_number: "626-111-1111",
      description: "I love pets"
    )

    PetApplication.create(pet_id: @pet_1.id, application_id: jae.id)
    expect(@shelter_1.pending_pets?).to eq(false)
  end
end
