require 'rails_helper'
RSpec.describe "when on shelter show page" do
  it "I can click delete next to a shelter review that deletes review" do
    shelter_1 = Shelter.create(
      name: "Paws For You",
      address: "1234 W Elf Ave",
      city: "Denver",
      state: "Colorado",
      zip: "90210")
    review1 = shelter_1.reviews.create!(title:"Claws for you",rating: 2,content: "I have never left a place with so many scratches.")

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content(review1.title)
    expect(page).to have_link("Delete review")
    within ".review-#{review1.id}" do
      expect(page).to have_content(review1.title)
      expect(page).to have_link("Delete review")
      click_link("Delete review")
    end
    expect(current_path).to eq("/shelters/#{shelter_1.id}")
    save_and_open_page
    expect(page).to_not have_content("Claws for you")
  end
end
