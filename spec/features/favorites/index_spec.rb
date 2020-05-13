require "rails_helper"

RSpec.describe "Favorite a Pet" do
  it "I can see list of my favorite pets" do
    visit "/favorites"
    expect(page).to have_content ("No Favorited Pets")
  end
end
