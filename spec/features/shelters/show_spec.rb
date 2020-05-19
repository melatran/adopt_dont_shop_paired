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

    @pet_1 = Pet.create(
      image: 'https://www.petful.com/wp-content/uploads/2014/01/maltese-1.jpg',
      name: "MoMo",
      approximate_age: "4",
      sex: "male",
      name_of_shelter_where_pet_is_currently_located: "Paws For You",
      shelter_id: @shelter_1.id
      )

    @pet_2 = Pet.create(
      image: 'https://www.petful.com/wp-content/uploads/2014/01/altese-1.jpg',
      name: "MoMo",
      approximate_age: "4",
      sex: "male",
      name_of_shelter_where_pet_is_currently_located: "Paws For You",
      shelter_id: @shelter_1.id
        )
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

  it "I can click on link to view all pets in the shelter" do
    visit "/shelters/#{@shelter_1.id}"

    within ".edit-buttons-#{@shelter_1.id}" do
      click_link "View All Pets in Paws For You"
    end
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
  end

  it "can display all written reviews" do
    review1 = @shelter_1.reviews.create!(title:"Claws for you",rating: 2,content: "I have never left a place with so many scratches.")
    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_content(review1.title)
    expect(page).to have_content(review1.rating)
    expect(page).to have_content(review1.content)
  end

  it "can display the total number of pets a shelter has" do
    visit "/shelters/#{@shelter_1.id}"
    expect(page).to have_content("Number of Pets: 2")
  end

  it "can display the average rating" do
    review1 = @shelter_1.reviews.create!(title:"Claws for you",rating: 2,content: "I have never left a place with so many scratches.")

    review2 = @shelter_1.reviews.create!(title:"Pew Pew",rating: 4,content: "Cute pets available.")

    review3 = @shelter_1.reviews.create!(title:"Buddy and Me",rating: 4,content: "Found my new best friend")

    review3 = @shelter_2.reviews.create!(title:"Buddy and Me",rating: 4,content: "Found my new best friend")

    visit "/shelters/#{@shelter_1.id}"
    expect(page).to have_content("Average Rating: 3.3")
  end

  it "can display the number of applications on file" do
    jae = Application.create(
      name: "Jae Park",
      address: "1245 S Ahgase Way",
      city: "Arcadia",
      state: "CA",
      zip: "910023",
      phone_number: "626-111-1111",
      description: "I work from home so I have plenty of time to be with the pet"
    )

    toph = Application.create(
      name: "Toph Appa",
      address: "1245 S Ahgase Way",
      city: "Arcadia",
      state: "CA",
      zip: "910023",
      phone_number: "626-111-1111",
      description: "I work from home so I have plenty of time to be with the pet"
    )

    PetApplication.create(pet_id: @pet_1.id, application_id: jae.id)
    PetApplication.create(pet_id: @pet_1.id, application_id: toph.id)

    visit "/shelters/#{@shelter_1.id}"
    expect(page).to have_content("Number of Applications: 2")
  end
end
