require 'rails_helper'
RSpec.describe "when I visit the favorites index page" do
  before :each do
    @shelter_1 = Shelter.create(
      name: "Paws For You",
      address: "1234 W Elf Ave",
      city: "Denver",
      state: "Colorado",
      zip: "90210",
    )

    @pet_1 = @shelter_1.pets.create(
      image: 'https://www.petful.com/wp-content/uploads/2014/01/maltese-1.jpg',
      name: "MoMo",
      approximate_age: "4",
      sex: "male",
      shelter_id: @shelter_1.id
    )

    @pet_2 = @shelter_1.pets.create(
      image: 'https://www.petful.com/wp-content/uploads/2014/01/maltese-1.jpg',
      name: "Lucy",
      approximate_age: "4",
      sex: "male",
      shelter_id: @shelter_1.id
    )
    @application = @pet_1.applications.create!(name: "Jae Park",
                                            address: "1234 S Ahgase Way",
                                            city: "Arcadia",
                                            state: "CA",
                                            zip: "91006",
                                            phone_number: "626-111-1111",
                                            description: "I work from home so I have plenty of time to be with the pet.")

  end
  
  it "will display a list of pet names that have 1+ applications" do
    visit "/favorites"

    within ".applied_pets" do

      expect(page).to have_content(@pet_1.name)

      click_link "#{@pet_1.name}"

    end

    expect(current_path).to eq("/pets/#{@pet_1.id}")
  end

end
