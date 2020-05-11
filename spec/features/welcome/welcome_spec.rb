require 'rails_helper'

RSpec.describe "as a user, on the welcome page", type: :feature do
  it "can see a welcome message" do
    visit '/'
    expect(page).to have_content("Adopt Don't Shop!")
  end

  it "can click on shelters" do
    visit '/'
    expect(page).to have_link("Shelter Index")

    click_on "Shelter Index"

    expect(current_path).to eq("/shelters")
  end

  it "can click on pets" do
    visit '/'
    expect(page).to have_link("Pet Index")

    click_on "Pet Index"

    expect(current_path).to eq("/pets")
  end
end
