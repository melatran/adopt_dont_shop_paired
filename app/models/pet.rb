class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications, dependent: :destroy
  has_many :applications, through: :pet_applications

  validates_presence_of :image, :name, :approximate_age, :sex
end
