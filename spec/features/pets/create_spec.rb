require 'rails_helper'

RSpec.describe "Shelter Pets Index" do
  before :each do
    @shelter_1 = Shelter.create(
      name: "Paws For You",
      address: "1234 W Elf Ave",
      city: "Denver",
      state: "Colorado",
      zip: "90210",
    )
  end

  describe "when i see a link to add new pet" do
    it "i can create new pet in form" do

      visit "/shelters/#{@shelter_1.id}/pets"
      click_on "Create Pet"
      expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets/new")

      fill_in :image, with: "https://www.petful.com/wp-content/uploads/2014/01/maltese-1.jpg"
      fill_in :name, with: "MoMo"
      fill_in :description, with: "cuddly but spoiled"
      fill_in :approximate_age, with: "4"
      find('#sex').find(:xpath, 'option[2]').click
      click_on 'Create Pet'

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
      expect(page).to have_content("MoMo")
    end
  end

  it "I can click on link and return to shelters index page" do
    visit "/shelters/#{@shelter_1.id}/pets/new"
    click_on "Return to Shelters Index"
    expect(current_path).to eq("/shelters")
  end

  it "I can click on link and return to pets index page" do
    visit "/shelters/#{@shelter_1.id}/pets/new"
    click_on "Return to Pets Index"
    expect(current_path).to eq("/pets")
  end

  it "I can click on link and return to shelters page" do
    visit "/shelters/#{@shelter_1.id}/pets/new"
    click_on "Return to Paws For You"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
  end
end
