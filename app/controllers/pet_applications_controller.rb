class PetApplications < ApplicationController
  def approve
    require "pry"; binding.pry
    @application = Application.find(params[:id])
    pet = Pet.find(params[:id])
     if pet.status == "pending"
       flash[:notice] = "This pet has already been approved for adoption"
       require "pry"; binding.pry
       redirect_to "applications/"
     else
       pet.status = "pending"
       pet.save!
       redirect_to "/pets/#{pet.id}"
     end
  end
end
