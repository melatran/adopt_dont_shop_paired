require 'rails_helper'
RSpec.describe "when use visits favorites page" do
  it "can remove a favorite from favorite page" do

    visit "/favorites"

    within ""



  end
  

end
# ```
# [ ] done
#
# User Story 13, Remove a Favorite from Favorites Page
#
# As a visitor
# When I have added pets to my favorites list
# And I visit my favorites page ("/favorites")
# Next to each pet, I see a button or link to remove that pet from my favorites
# When I click on that button or link to remove a favorite
# A delete request is sent to "/favorites/:pet_id"
# And I'm redirected back to the favorites page where I no longer see that pet listed
# And I also see that the favorites indicator has decremented by 1
# ```
