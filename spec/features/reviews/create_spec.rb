require 'rails_helper'
# [ ] done
#
# User Story 2, Shelter Reviews
#
# As a visitor,
# When I visit a shelter's show page,
# I see a list of reviews for that shelter
# Each review will have:
# - title
# - rating
# - content
# - an optional picture
# `

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
end
# [ ] done
#
# User Story 3, Shelter Review Creation
#
# As a visitor,
# When I visit a shelter's show page
# I see a link to add a new review for this shelter.
# When I click on this link, I am taken to a new review path
# On this new page, I see a form where I must enter:
# - title
# - rating
# - content
# I also see a field where I can enter an optional image (web address)
# When the form is submitted, I should return to that shelter's show page
# and I can see my new review
# ```
#
# ```
# [ ] done
#
# User Story 4, Shelter Review Creation, cont.
#
# As a visitor,
# When I fail to enter a title, a rating, and/or content in the new shelter review form, but still try to submit the form
# I see a flash message indicating that I need to fill in a title, rating, and content in order to submit a shelter review
# And I'm returned to the new form to create a new review
# ```
