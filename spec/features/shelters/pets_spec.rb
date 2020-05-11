require 'rails_helper'

RSpec.describe "when i visit the shelter index", type: :feature do
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

  it "can see all pets in shelter" do

    visit "/shelters/#{@shelter_1.id}"
    expect(page).to have_link("Pets")

    click_on "View All Pets in Paws For You"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
    expect(page).to have_css("img[src='#{@pet_1.image}']")
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_1.approximate_age)
    expect(page).to have_content(@pet_1.sex)
  end

  it "I can update pets from a link" do
    visit "/shelters/#{@shelter_1.id}/pets"
    expect(page).to have_link("Update Pet")
  end

  it "I can delete pets from a link" do
    visit "/shelters/#{@shelter_1.id}/pets"
    expect(page).to have_link("Delete Pet")
  end

  it "I can click on pet's name and get to pet show page" do
    visit "/shelters/#{@shelter_1.id}/pets"
    expect(page).to have_content(@pet_1.name)
    click_on @pet_1.name
    expect(current_path).to eq("/pets/#{@pet_1.id}")
  end

  it "I can click on link and return to shelters index page" do
    visit "/shelters/#{@shelter_1.id}/pets"
    click_on "Return to Shelters Index"
    expect(current_path).to eq("/shelters")
  end

  it "I can click on link and return to pets index page" do
    visit "/shelters/#{@shelter_1.id}/pets"
    click_on "Return to Pets Index"
    expect(current_path).to eq("/pets")
  end

  it "I can see total number of pets a shelter has" do
    visit "/shelters/#{@shelter_1.id}/pets"
    expect(page).to have_content("1")
  end

  it "I can click on link to create pet" do
    visit "/shelters/#{@shelter_1.id}/pets"
    click_on "Create Pet"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets/new")
  end
end
