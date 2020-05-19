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
    Pet.destroy(params[:id])
    redirect_to '/pets'
  end

  def approve
    pet = Pet.find(params[:id])
    if pet.status == "pending"
      flash[:notice] = "Pet has already been approved for adoption"
      redirect_to "/pets/#{pet.id}"
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
