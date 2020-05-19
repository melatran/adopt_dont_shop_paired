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

    @pet_1 = @shelter_1.pets.create(
      image: 'https://www.petful.com/wp-content/uploads/2014/01/maltese-1.jpg',
      name: "Momo",
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
    @application1 = @pet_1.applications.create!(name: "Mae Park",
                                            address: "1234 S Ahgase Way",
                                            city: "Arcadia",
                                            state: "CA",
                                            zip: "91006",
                                            phone_number: "626-111-1111",
                                            description: "I work from home so I have plenty of time to be with the pet.")
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


  it "should be able to approve pet for adoption" do

    application = Application.last
    visit "/applications/#{application.id}"


    click_link "Approve Momo"

    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("pending")
    expect(page).to have_content("On hold for #{@application1.name}")
    #need to connect pet with application name for display message
  end

  it "should be able to approve multiple pets for adoption" do
    shelter_1 = Shelter.create(
      name: "Paws For You",
      address: "1234 W Elf Ave",
      city: "Denver",
      state: "Colorado",
      zip: "90210",
    )

    pet_1 = Pet.create(
      image: 'https://www.petful.com/wp-content/uploads/2014/01/maltese-1.jpg',
      name: "MoMo",
      approximate_age: "4",
      sex: "male",
      shelter_id: shelter_1.id
    )

    application = Application.create(
      name: "Jae Park",
      address: "1245 S Ahgase Way",
      city: "Arcadia",
      state: "CA",
      zip: "910023",
      phone_number: "626-111-1111",
      description: "I work from home so I have plenty of time to be with the pet"
    )

    PetApplication.create(pet_id: pet_1.id, application_id: application.id)
    PetApplication.create(pet_id: @pet_2.id, application_id: application.id)

    visit "/applications/#{application.id}"
    click_link "Approve MoMo"

    visit "/pets/#{pet_1.id}"
    expect(page).to have_content("pending")

    visit "/applications/#{application.id}"
    click_link "Approve Lucy"
    visit "/pets/#{@pet_2.id}"
    expect(page).to have_content("pending")

  end

end
