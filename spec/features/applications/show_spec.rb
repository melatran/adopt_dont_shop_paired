require 'rails_helper'
RSpec.describe "when I visit an applications show page" do
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
      approximate_age: "4",
      sex: "male",
      shelter_id: @shelter_1.id
    )
    visit "/pets/#{@pet_1.id}"
    within ".pets-#{@pet_1.id}" do
      click_link "Favorite"
    end

    visit "/pets/#{@pet_2.id}"
    within ".pets-#{@pet_2.id}" do
      click_link "Favorite"
    end

    visit '/favorites'
    click_link "Apply to Adopt"

    select("#{@pet_1.name}")
    select("#{@pet_2.name}")
    fill_in :name, with: "Jae Park"
    fill_in :address, with: "1234 S Ahgase Way"
    fill_in :city, with: "Arcadia"
    fill_in :state, with: "CA"
    fill_in :zip, with: "91006"
    fill_in :phone_number, with: "626-111-1111"
    fill_in :description, with: "I work from home so I have plenty of time to be with the pet."

    click_on "Submit Application"
  end
  it "should display all the apps info and the pets that app is for" do
    application = Application.last
    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip)
    expect(page).to have_content(application.phone_number)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.pets.first.name)
    expect(page).to have_content(application.pets.last.name)
  end

end
