require 'rails_helper'

RSpec.describe "review creation page" do
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
    end
  it "can write a review from a shelters show page" do
    visit "/shelters/#{@shelter_1.id}"

    click_link "Add review for this shelter"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/new_review")

    fill_in :title, with: 'Claws for you'
    fill_in :rating, with: 2
    fill_in :content, with: 'I have never left a place with so many scratches.'

    click_on "Submit"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    expect(page).to have_content('Claws for you')
    expect(page).to have_content(2)
    expect(page).to have_content('I have never left a place with so many scratches.')
  end

  it "will display flash message prompting user to fill in all forms" do
    visit "/shelters/#{@shelter_1.id}"

    click_link "Add review for this shelter"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/new_review")

    fill_in :title, with: 'Claws for you'
    click_on "Submit"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/new_review")
    expect(page).to have_content("Review not created: please fill out all indicated fields")
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/new_review")
  end
end
