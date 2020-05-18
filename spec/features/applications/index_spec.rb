require "rails_helper"

RSpec.describe "Pet Application Index" do
  it "I can view all applications for a pet" do
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
      shelter_id: shelter_1.id
    )

    jae = Application.create(
      name: "Jae Park",
      address: "1245 S Ahgase Way",
      city: "Arcadia",
      state: "CA",
      zip: "910023",
      phone_number: "626-111-1111",
      description: "I work from home so I have plenty of time to be with the pet"
    )

    PetApplication.create(pet_id: pet_1.id, application_id: jae.id)

    visit "/pets/#{pet_1.id}"
    click_link "View All Applicants"
    expect(current_path).to eq("/pets/#{pet_1.id}/applications")
    expect(page).to have_content("Jae Park")
    # click_link "Jae Park"
    # expect(page).to eq("applications/jae.id")
  end

  it "will display a message when there are no applicants" do
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
      shelter_id: shelter_1.id
    )

    visit "/pets/#{pet_1.id}"
    click_link "View All Applicants"
    expect(page).to have_content("There are no applications for this pet")
  end
end
