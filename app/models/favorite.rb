class Favorite < ApplicationRecord
  attr_reader :pets

  def initialize(pets)
    @pets = pets || []
  end

  def total_favorites
    pets.length
  end
end
