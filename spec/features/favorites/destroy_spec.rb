require 'rails_helper'
RSpec.describe "when use visits favorites page" do
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

    @pet_2 = Pet.create(
      image: 'https://www.petful.com/wp-content/uploads/2014/01/maltese-1.jpg',
      name: "MoMo the 2nd",
      approximate_age: "1",
      sex: "male",
      shelter_id: @shelter_1.id
    )
  end
  it "can remove a favorite from favorite page" do

    visit "/pets/#{@pet_1.id}"

    within ".pets-#{@pet_1.id}" do
      click_link "Favorite"
    end
    visit "/pets/#{@pet_2.id}"

    within ".pets-#{@pet_2.id}" do
      click_link "Favorite"
    end


    visit "/favorites"
    expect(page). to have_content
    click_link "Remove All Favorites"
    expect(current_path).to eq("/favorites")
    expect(page).to have_content("Favorites: 0")
    expect(page).to have_content("No Favorited Pets")
  end
end
