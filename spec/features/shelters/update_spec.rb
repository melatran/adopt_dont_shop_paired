require 'rails_helper'

RSpec.describe "as a user, when i visit the shelters index", type: :feature do
  before :each do
    @shelter_1 = Shelter.create(
      name: "Paws For You",
      address: "1234 W Elf Ave",
      city: "Denver",
      state: "CO",
      zip: "90210")
  end

  it "can update a shelters information" do

    visit "/shelters/#{@shelter_1.id}"
    expect(page).to have_link("Update Shelter")
    click_link "Update Shelter"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")

    fill_in :name, with: "MoMo's Adoption"

    click_on "Update Shelter"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    expect(page).to have_content("MoMo's Adoption")
    expect(page).to have_content("1234 W Elf Ave")
    expect(page).to have_content("Denver")
    expect(page).to have_content("CO")
    expect(page).to have_content("90210")
  end

  it "I can click on link and return to shelters index page" do
    visit "/shelters/#{@shelter_1.id}/edit"
    click_on "Return to Shelters Index"
    expect(current_path).to eq("/shelters")
  end

  it "I can click on link and return to pets index page" do
    visit "/shelters/#{@shelter_1.id}/edit"
    click_on "Return to Pets Index"
    expect(current_path).to eq("/pets")
  end

  it "I can click on link to return to shelter page" do
    visit "/shelters/#{@shelter_1.id}/edit"
    click_on "Return to Paws For You"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
  end
end
