class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy

  def total_pets
    self.pets.count
  end
end
