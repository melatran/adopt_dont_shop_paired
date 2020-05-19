class FavoritesController < ApplicationController
  def index
    @pets = favorite.favorite_pets
    @all_pets = Pet.all
  end

  def update
    pet = Pet.find(params[:pet_id])
    favorite.already_favorited?(pet.id)
    session[:favorite] = favorite.contents
    flash[:notice] = "#{pet.name} has been added to your favorites"
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    favorite.remove_pet(pet.id)
    flash[:notice] = "#{pet.name} has been removed from your favorites"
    redirect_to "/pets/#{pet.id}"
  end

  def remove_all
    reset_session
    redirect_to '/favorites'
  end
end
