require 'rails_helper'

RSpec.describe "as a user, when i visit the index page", type: :feature do
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
  end

  it "can show the pets" do

    visit "/pets/#{@pet_1.id}"
    expect(page).to have_css("img[src='#{@pet_1.image}']")
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_1.description)
    expect(page).to have_content(@pet_1.approximate_age)
    expect(page).to have_content(@pet_1.sex)
    expect(page).to have_content(@pet_1.status)
  end

  it "I can click on link and return to shelters index page" do
    visit "/pets/#{@pet_1.id}"
    click_on "Return to Shelters Index"
    expect(current_path).to eq("/shelters")
  end

  it "I can click on link and return to pets index page" do
    visit "/pets/#{@pet_1.id}"
    click_on "Return to Pets Index"
    expect(current_path).to eq("/pets")
  end

  it "I can click on link to update pet" do
    visit "/pets/#{@pet_1.id}"
    expect(page).to have_content("Update Pet")
  end

  it "I can click on link to delete pet" do
    visit "/pets/#{@pet_1.id}"
    expect(page).to have_content("Delete Pet")
  end
end
