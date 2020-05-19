require 'rails_helper'

RSpec.describe "Application Form" do
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
  end

  describe "When I want to adopt a pet" do
    it "I can fill out new application form" do
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
      expect(current_path).to eq("/applications/new")

      select("#{@pet_1.name}")
      fill_in :name, with: "Jae Park"
      fill_in :address, with: "1234 S Ahgase Way"
      fill_in :city, with: "Arcadia"
      fill_in :state, with: "CA"
      fill_in :zip, with: "91006"
      fill_in :phone_number, with: "626-111-1111"
      fill_in :description, with: "I work from home so I have plenty of time to be with the pet."

      click_on "Submit Application"
      expect(page).to have_content("You have successfully submitted your application")

      visit '/favorites'

      expect(page).to have_content(@pet_2.name)
    end

    it "I will get errors if application form is not completed in its entirety" do
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
      expect(current_path).to eq("/applications/new")

      select("#{@pet_1.name}")
      fill_in :name, with: "Jae Park"
      fill_in :address, with: "1234 S Ahgase Way"
      fill_in :city, with: "Arcadia"
      fill_in :zip, with: "91006"
      fill_in :phone_number, with: "626-111-1111"
      fill_in :description, with: "I work from home so I have plenty of time to be with the pet."

      click_on "Submit Application"
      expect(page).to have_content("Application not created: please fill out all indicated fields")
      expect(current_path).to eq("/applications/new")
    end
  end
end


# User Story 16, Applying for a Pet
#
# As a visitor
# When I have added pets to my favorites list
# And I visit my favorites page ("/favorites")
# I see a link for adopting my favorited pets
# When I click that link I'm taken to a new application form
# At the top of the form, I can select from the pets of which I've favorited for which I'd like this application to apply towards (can be more than one)
# When I select one or more pets, and fill in my
# - Name
# - Address
# - City
# - State
# - Zip
# - Phone Number
# - Description of why I'd make a good home for this/these pet(s)
# And I click on a button to submit my application
# I see a flash message indicating my application went through for the pets that were selected
# And I'm taken back to my favorites page where I no longer see the pets for which I just applied listed as favorites
