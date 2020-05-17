class Favorite
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents ||= Hash.new
  end

  def total_count
    @contents.values.sum
  end

  def add_pet(id)
    @contents[id.to_s] = count_of(id) + 1
  end

  #if it's already favorited, dont add
  #if its not already favorited, add pet
  def already_favorited?(id)
    if !@contents.has_key?(id.to_s)
      add_pet(id)
    end
  end

  def included_pet?(id)
    @contents
  end

  def count_of(id)
    @contents[id.to_s].to_i
  end

  #{pet.id => 1} ....use id to find pet object
  def favorite_pets
    @contents.keys.map do |id|
      Pet.find(id)
    end
  end
end
