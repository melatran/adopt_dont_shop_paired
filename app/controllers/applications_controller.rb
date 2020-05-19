class ApplicationsController < ApplicationController
  def index
    @favorited_pets = Pet.find(params[:id])
  end

  def new
    @pets = favorite.favorite_pets
  end

  def create
    application = Application.new(application_params)
    #pry into params to check if anything is present
    #favorite_pets params from new
    favorited_pets = Pet.where(id: params[:favorite_pets])
    if application.save
      favorited_pets.each do |pet|
        PetApplication.create(pet_id: pet.id, application_id: application.id)
        favorite.remove_pet(pet.id)
        #this id has to match what we want back from remove_pet method
      end
      flash[:notice] = "You have successfully submitted your application"
      redirect_to '/favorites'
    else
      flash[:notice] = "Application not created: please fill out all indicated fields"
      redirect_to '/applications/new'

    end
  end

  def show
    @application = Application.find(params[:id])
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
