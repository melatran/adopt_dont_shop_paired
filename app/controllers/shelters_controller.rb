class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
    @reviews = Review.all
  end

  def new
  end

  def create
    shelter = Shelter.new(shelter_params)
    if shelter.save
      flash[:notice] = "Shelter successfully created!"
      redirect_to '/shelters'
    else
      flash[:notice] = "Failure! Please fill in all fields!"
      redirect_to "/shelters/new"
    end
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update(shelter_params)
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    shelter = Shelter.find(params[:id])
    if shelter.pending_pets?
      flash[:notice] = "Shelter can't be deleted due to pending pets."
      redirect_to "/shelters/#{shelter.id}"
    else
      Shelter.destroy(params[:id])
      redirect_to '/shelters'
    end
  end

  def pets
    @shelter = Shelter.find(params[:id])
    @list_of_pets = @shelter.pets
  end

  private

  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
