class Favorite
  attr_reader :pets

  def initialize(pets = [])
    @pets = pets
  end

  def total_favorites
    pets.length
  end

  def add_pet(id)
    @pets << id
  end
end
