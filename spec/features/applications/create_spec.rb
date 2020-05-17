require 'rails_helper'

RSpec.describe "Application Form" do
  describe "When I want to adopt a pet" do
    it "I can fill out new application form" do
      visit '/favorites'


      click_link "Apply to Adopt"


      expect(current_path).to eq("/applications/new")

      fill_in :name, with: "Jae Park"
      fill_in :address, with: "1234 S Ahgase Way"
      fill_in :city, with: "Arcadia"
      fill_in :state, with: "CA"
      fill_in :zip, with: "91006"
      fill_in :phone_number, with: "626-111-1111"
      fill_in :description, with: "I work from home so I have plenty of time to be with the pet."

      click_on "Submit Application"
      expect(current_path).to eq("/favorites")
    end
  end
end
