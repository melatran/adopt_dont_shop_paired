class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter = Shelter.find(params[:id])
    pet = shelter.pets.new(pet_params)
    if pet.save(pet_params)
      flash[:notice] = "Pet successfully created!"
      redirect_to "/shelters/#{shelter.id}/pets"
    else
      flash[:notice] = "Pet not created: please fill out all forms"
      redirect_to "/shelters/#{shelter.id}/pets/new"
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)

    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:id])
    if pet.status == "adoptable"
      favorite.remove_pet(pet.id)
      Pet.destroy(params[:id])
      redirect_to '/pets'
    else
      flash[:notice] = "You cannot delete a pet with a pending adoption"
      redirect_to "/pets/#{pet.id}"
    end
  end

  def approve
    pet = Pet.find(params[:id])
    if pet.status == "pending"
      pet.status = "adoptable"
      pet.save!
      redirect_to "/pets/#{pet.id}/applications"
    else
      pet.status = "pending"
      pet.save!
      redirect_to "/pets/#{pet.id}"
    end
  end

  private
  def pet_params
    params.permit(:image, :name, :approximate_age, :description, :sex, :status, :favorite)
  end
end
