require "rails_helper"

RSpec.describe "Update Review from Shelter Show Page" do
  it "can update a review" do
    shelter_1 = Shelter.create(
      name: "Paws For You",
      address: "1234 W Elf Ave",
      city: "Denver",
      state: "Colorado",
      zip: "90210")

    review1 = shelter_1.reviews.create!(title:"Claws for you",rating: 2,content: "I have never left a place with so many scratches.")

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content(review1.title)
    expect(page).to have_link("Edit review")

    within ".review-#{review1.id}" do
      expect(page).to have_content(review1.title)
      expect(page).to have_link("Edit review")
      click_link("Edit review")
    end
    expect(current_path).to eq("/shelters/#{shelter_1.id}/#{review1.id}/edit")

    fill_in :content, with: "What are they feeding these pets?!"

    click_on("Update Review")
    expect(current_path).to eq("/shelters/#{shelter_1.id}")
  end

  it "can't update a review" do
    shelter_1 = Shelter.create(
      name: "Paws For You",
      address: "1234 W Elf Ave",
      city: "Denver",
      state: "Colorado",
      zip: "90210")

    review1 = shelter_1.reviews.create!(title:"Claws for you",rating: 2,content: "I have never left a place with so many scratches.")

    visit "/shelters/#{shelter_1.id}"
    click_link("Edit review")
    expect(current_path).to eq("/shelters/#{shelter_1.id}/#{review1.id}/edit")

    fill_in :title, with: nil

    click_on("Update Review")
    
    expect(page).to have_content("Updates haven't been made. Fill in all blanks")
  end
end
