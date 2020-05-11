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

  it "can show the attributes of the shelter with that id" do

    visit "/shelters/#{@shelter_1.id}"
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_1.address)
    expect(page).to have_content(@shelter_1.city)
    expect(page).to have_content(@shelter_1.state)
    expect(page).to have_content(@shelter_1.zip)

    visit "/shelters/#{@shelter_2.id}"
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_2.address)
    expect(page).to have_content(@shelter_2.city)
    expect(page).to have_content(@shelter_2.state)
    expect(page).to have_content(@shelter_2.zip)
  end

  it "I can click on link and return to shelters index page" do
    visit "/shelters/#{@shelter_1.id}"
    click_on "Return to Shelters Index"
    expect(current_path).to eq("/shelters")
  end

  it "I can click on link and return to pets index page" do
    visit "/shelters/#{@shelter_1.id}"
    click_on "Return to Pets Index"
    expect(current_path).to eq("/pets")
  end

  it "I can click on link to view all pets in the shelter" do
    visit "/shelters/#{@shelter_1.id}"
    click_on "View All Pets in Paws For You"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
  end
end
