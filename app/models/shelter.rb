class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def total_pets
    pets.count
  end

  def average_rating
    reviews.average(:rating).to_f
  end

  def total_applications
    pets.joins(:applications).count
  end

#are there any pending pets?

  def pending_pets?
    pets.where(status: "pending").any?
  end
end
