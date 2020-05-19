require "rails_helper"

RSpec.describe "Pet Show Page" do
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
      name: "Lucy",
      approximate_age: "4",
      sex: "female",
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

  it "I can delete the pet" do

    visit "/pets/#{@pet_1.id}"
    click_link "Delete Pet"
    expect(current_path).to eq("/pets")
    expect(page).to have_content("MoMo")
    expect(page).to_not have_content("Lucy")
  end
  it "cannot delete a pet with an approved application" do

    application = Application.create(
      name: "Jae Park",
      address: "1245 S Ahgase Way",
      city: "Arcadia",
      state: "CA",
      zip: "910023",
      phone_number: "626-111-1111",
      description: "I work from home so I have plenty of time to be with the pet"
    )

    PetApplication.create(pet_id: @pet_2.id, application_id: application.id)

    visit "/applications/#{application.id}"
    click_link "Approve #{@pet_2.name}"

    visit "/pets/#{@pet_2.id}"
    click_link "Delete Pet"
    expect(page).to have_content("You cannot delete a pet with a pending adoption")

  end

end
