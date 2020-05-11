require 'rails_helper'

RSpec.describe "pets index page", type: :feature do
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
      name: "Lucy",
      approximate_age: "6",
      sex: "female",
      shelter_id: @shelter_1.id
    )

  end

  it "can see all pets" do

    visit '/pets'
    expect(page).to have_css("img[src='#{@pet_1.image}']")
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_1.approximate_age)
    expect(page).to have_content(@pet_1.sex)
    expect(page).to have_content(@pet_1.shelter.name)
    expect(page).to have_css("img[src='#{@pet_2.image}']")
    expect(page).to have_content(@pet_2.name)
    expect(page).to have_content(@pet_2.approximate_age)
    expect(page).to have_content(@pet_2.sex)
    expect(page).to have_content(@pet_2.shelter.name)
  end

  it "I can update pets from a link" do
    visit '/pets'
    expect(page).to have_link("Update Pet")
  end

  it "I can delete pets from a link" do
    visit '/pets'
    expect(page).to have_link("Delete Pet")
  end

  it "I can click on link to return to shelters" do
    visit '/pets'
    click_on "Return to Shelters Index"
    expect(current_path).to eq("/shelters")
  end

  it "I can click on name of shelter to shelters show page" do
    visit '/pets'
    expect(page). to have_link("Paws For You")
  end
end
