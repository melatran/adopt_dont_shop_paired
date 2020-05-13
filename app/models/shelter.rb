class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :reviews

  def total_pets
    self.pets.count
  end
end
