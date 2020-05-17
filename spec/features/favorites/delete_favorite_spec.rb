require 'rails_helper'

RSpec.describe "Favorite Pet" do
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
      shelter_id: @shelter_1.id
    )
  end
  
  it "I can remove favorited pet from show page" do
    visit "/pets/#{@pet_1.id}"

    within ".pets-#{@pet_1.id}" do
      click_link "Favorite"
    end

    visit "/pets/#{@pet_1.id}"
    expect(page).to have_content("Favorites: 1")
    click_link "Remove"
    expect(page).to have_content("#{@pet_1.name} has been removed from your favorites")

    visit "/pets/#{@pet_1.id}"

    expect(page).to have_content("Favorite")
    expect(page).to have_content("Favorites: 0")
  end
end
