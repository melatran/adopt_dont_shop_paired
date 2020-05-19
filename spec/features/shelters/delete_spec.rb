require 'rails_helper'

RSpec.describe "as a user, when i visit the shelters index", type: :feature do
  before :each do
    @shelter_1 = Shelter.create(
      name: "Paws For You",
      address: "1234 W Elf Ave",
      city: "Denver",
      state: "Colorado",
      zip: "90210")

    @shelter_2 = Shelter.create(
      name: "Forever Pet",
      address: "1234 S Ahgase Blvd",
      city: "Boulder",
      state: "Colorado",
      zip: "90210")
  end

  it "can delete a shelter" do

    visit "/shelters/#{@shelter_2.id}"
    expect(page).to have_link("Delete Shelter")
    click_link "Delete Shelter"
    expect(current_path).to eq("/shelters")
    expect(page).to have_content(@shelter_1.name)
    expect(page).to_not have_content(@shelter_2.name)
  end

  it "cant delete a shelter with pending status pets" do
    pet= Pet.create(
      image: 'https://www.petful.com/wp-content/uploads/2014/01/maltese-1.jpg',
      name: "MoMo",
      approximate_age: "4",
      sex: "male",
      shelter_id: @shelter_1.id
    )

    application = Application.create(
      name: "Melanie",
      address: "1245 S Ahgase Way",
      city: "Arcadia",
      state: "CA",
      zip: "910023",
      phone_number: "626-111-1111",
      description: "I work from home so I have plenty of time to be with the pet"
    )

    PetApplication.create(pet_id: pet.id, application_id: application.id)

    visit "/applications/#{application.id}"
    click_link "Approve MoMo"

    visit "/shelters/#{@shelter_1.id}"
    click_link "Delete Shelter"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    expect(page).to have_content("Shelter can't be deleted due to pending pets.")
  end
end
