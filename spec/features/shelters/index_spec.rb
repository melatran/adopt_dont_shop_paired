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

  it "can see the names of each shelter" do
    visit "/shelters"
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
  end

  it "I can see an edit link next to the shelter" do
    visit "/shelters"
    expect(page).to have_link("Edit Shelter")
  end

  it "I can delete shelter from shelter index" do
    visit "/shelters"
    expect(page).to have_link("Delete Shelter")
  end

  it "I can click on the name and it will bring me to the shelter show page" do
    visit "/shelters"
    expect(page).to have_content(@shelter_1.name)
    click_on @shelter_1.name
    expect(current_path). to eq("/shelters/#{@shelter_1.id}")
  end

  it "I can click on link to pets index" do
    visit '/shelters'
    click_on "Return to Pets Index"
    expect(current_path).to eq("/pets")
  end

  it "I can create a new shelter from link" do
    visit '/shelters'
    click_on "Create New Shelter"
    expect(current_path).to eq('/shelters/new')
  end
end
