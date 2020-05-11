require 'rails_helper'

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
      name: "MoMo",
      description: "spoiled",
      approximate_age: "4",
      sex: "Male",
      shelter_id: @shelter_1.id,
    )
  end

  describe "when I see a link to update pets" do
    it "I can update pet" do

      visit "/pets/#{@pet_1.id}"
      click_link "Update Pet"
      expect(current_path).to eq("/pets/#{@pet_1.id}/edit")

      fill_in :description, with: "loves to nap"

      click_on "Update Pet"
      expect(current_path).to eq("/pets/#{@pet_1.id}")
      expect(page).to have_content("loves to nap")
      expect(page).to have_content("MoMo")
      expect(page).to have_content("4")
      expect(page).to have_content("Male")
    end
  end

  it "I can click on link and return to shelters index page" do
    visit "/pets/#{@pet_1.id}/edit"
    click_on "Return to Shelters Index"
    expect(current_path).to eq("/shelters")
  end

  it "I can click on link and return to pets index page" do
    visit "/pets/#{@pet_1.id}/edit"
    click_on "Return to Pets Index"
    expect(current_path).to eq("/pets")
  end
end
