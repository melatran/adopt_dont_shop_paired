require "rails_helper"

RSpec.describe Favorite, type: :model do
  describe "relationships" do
    it {should have_many: favorite_pets}
  end
end
